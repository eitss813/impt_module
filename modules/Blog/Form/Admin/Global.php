<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Blog
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Global.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Blog
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Blog_Form_Admin_Global extends Engine_Form
{
  public function init()
  {

    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');
/*
    $this->addElement('Radio', 'blog_public', array(
      'label' => 'Public Permissions',
      'description' => "BLOG_FORM_ADMIN_GLOBAL_BLOGPUBLIC_DESCRIPTION",
      'multiOptions' => array(
        1 => 'Yes, the public can view blogs unless they are made private.',
        0 => 'No, the public cannot view blogs.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('blog.public', 1),
    ));
*/
    $this->addElement('Text', 'blog_page', array(
      'label' => 'Entries Per Page',
      'description' => 'How many blog entries will be shown per page? (Enter a number between 1 and 999)',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('blog.page', 10),
    ));

      $this->addElement('Radio', 'blog_allow_unauthorized', array(
          'label' => 'Make unauthorized blogs searchable?',
          'description' => 'Do you want to make a unauthorized blogs searchable? (If set to no, blogs that are not authorized for the current user will not be displayed in the blog search results and widgets.)',
          'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('blog.allow.unauthorized',0),
          'multiOptions' => array(
              '1' => 'Yes',
              '0' => 'No',
          ),
      ));
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}
