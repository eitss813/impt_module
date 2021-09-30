<?php

/**
 * socialnetworking.solutions
 *
 * @category   Application_Modules
 * @package    Sesblog
 * @copyright  Copyright 2014-2020 Ahead WebSoft Technologies Pvt. Ltd.
 * @license    https://socialnetworking.solutions/license/
 * @version    $Id: Profilevideos.php 2016-07-23 00:00:00 socialnetworking.solutions $
 * @author     socialnetworking.solutions
 */

class Sesblog_Form_Admin_Profilevideos extends Engine_Form {

  public function init() {

    $this->addElement('MultiCheckbox', "enableTabs", array(
        'label' => "Choose the View Type for videos.",
        'multiOptions' => array(
            'list' => 'List View',
            'grid' => 'Grid View',
            'pinboard' => 'Pinboard View'
        ),
        'value' => 'list',
    ));

    $this->addElement('Select', "openViewType", array(
        'label' => 'Choose the view type which you want to display by default. (Settings will apply, if you have selected more than one option in above tab.)?',
        'multiOptions' => array(
            'list' => 'List View',
            'grid' => 'Grid View',
            'pinboard' => 'Pinboard View',
        ),
        'value' => 'list',
    ));

    $this->addElement('MultiCheckbox', "show_criteria", array(
        'label' => "Choose from below the details that you want to show in this widget.",
        'multiOptions' => array(
//             'featuredLabel' => 'Featured Label',
//             'sponsoredLabel' => 'Sponsored Label',
//             'hotLabel' => 'Hot Label',
            'watchLater' => 'Watch Later',
            'favouriteButton' => 'Favourite Button',
            'playlistAdd' => 'Playlist Add Button',
            'likeButton' => 'Like Button',
            'socialSharing' => 'Social Share Buttons <a class="smoothbox" href="admin/sesbasic/settings/faqwidget">[FAQ]</a>',
            'watchLater' => 'Watch Later Button',
            'like' => 'Likes',
            'comment' => 'Comments',
            'favourite' => 'Favourite Count',
            'rating' => 'Ratings',
            'view' => 'Views',
            'title' => 'Title',
            'category' => 'Category',
            'by' => 'Item Owner Name',
            'duration' => 'Duration',
            'description' => 'Description (List View only)',
        ),
        'escape' => false,
    ));

    //Social Share Plugin work
    if(Engine_Api::_()->getDbtable('modules', 'core')->isModuleEnabled('sessocialshare')) {
      
      $this->addElement('Select', "socialshare_enable_plusicon", array(
        'label' => "Enable More Icon for social share buttons?",
          'multiOptions' => array(
          '1' => 'Yes',
          '0' => 'No',
        ),
        'value' => 1,
      ));
      
      $this->addElement('Text', "socialshare_icon_limit", array(
          'label' => 'Count (number of social sites to show). If you enable More Icon, then other social sharing icons will display on clicking this plus icon.',
          'value' => 2,
          'validators' => array(
              array('Int', true),
              array('GreaterThan', true, array(0)),
          )
      ));
    }
    //Social Share Plugin work
    
    $this->addElement('Radio', "pagging", array(
        'label' => "Do you want the videos to be auto-loaded when users scroll down the page?",
        'multiOptions' => array(
            'auto_load' => 'Yes, Auto Load.',
            'button' => 'No, show View more',
            'pagging' => 'No, show \'Pagination\'.'
        ),
        'value' => 'auto_load',
    ));

    $this->addElement('Text', "title_truncation_list", array(
        'label' => 'Title truncation limit for List View.',
        'value' => 45,
        'validators' => array(
            array('Int', true),
            array('GreaterThan', true, array(0)),
        )
    ));

    $this->addElement('Text', "title_truncation_grid", array(
        'label' => 'Title truncation limit for Grid View.',
        'value' => 45,
        'validators' => array(
            array('Int', true),
            array('GreaterThan', true, array(0)),
        )
    ));

    $this->addElement('Text', "DescriptionTruncationList", array(
        'label' => 'Description truncation limit for List View.',
        'value' => 45,
        'validators' => array(
            array('Int', true),
            array('GreaterThan', true, array(0)),
        )
    ));

    $this->addElement('Text', "height", array(
        'label' => 'Enter the height of one video block (for Grid view in pixels).',
        'value' => '160',
    ));
    $this->addElement('Text', "width", array(
        'label' => 'Enter the width of one video block (for Grid view in pixels).',
        'value' => '140',
    ));

    $this->addElement('Text', "limit_data", array(
        'label' => 'count (number of videos to show).',
        'value' => 20,
        'validators' => array(
            array('Int', true),
            array('GreaterThan', true, array(0)),
        )
    ));
  }

}
