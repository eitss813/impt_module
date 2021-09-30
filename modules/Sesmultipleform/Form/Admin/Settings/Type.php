<?php
/**
 * SocialEngineSolutions
 *
 * @category   Application_Sesmultipleform
 * @package    Sesmultipleform
 * @copyright  Copyright 2015-2016 SocialEngineSolutions
 * @license    http://www.socialenginesolutions.com/license/
 * @version    $Id: Type.php 2015-12-31 00:00:00 SocialEngineSolutions $
 * @author     SocialEngineSolutions
 */
class Sesmultipleform_Form_Admin_Settings_Type extends Engine_Form {

  public function init() {

    $this->setMethod('POST')
            ->setAttrib('class', 'global_form_smoothbox');

    $this->addElement('Text', 'label', array(
        'label' => 'Profile Type Label',
        'required' => true,
        'allowEmpty' => false,
    ));

    //Get list of Member Types
    $db = Engine_Db_Table::getDefaultAdapter();
    $member_type_result = $db->select('option_id, label')
            ->from('engine4_sesmultipleform_entry_fields_options')
            ->where('field_id = ?', 1)
            ->query()
            ->fetchAll();
    $member_type_count = count($member_type_result);
    $member_type_array = array('null' => 'No, Create Blank Profile Type');
    for ($i = 0; $i < $member_type_count; $i++) {
      $member_type_array[$member_type_result[$i]['option_id']] = $member_type_result[$i]['label'];
    }

    $this->addElement('Button', 'execute', array(
        'label' => 'Add Profile Type',
        'ignore' => true,
        'decorators' => array('ViewHelper'),
        'type' => 'submit'
    ));

    $this->addElement('Cancel', 'cancel', array(
        'prependText' => ' or ',
        'label' => 'cancel',
        'link' => true,
        'href' => '',
        'onclick' => 'parent.Smoothbox.close();',
        'decorators' => array(
            'ViewHelper'
        ),
    ));

    $this->addDisplayGroup(array(
        'execute',
        'cancel'
            ), 'buttons');
  }

}
