<?php

/**
 * socialnetworking.solutions
 *
 * @category   Application_Modules
 * @package    Sesblog
 * @copyright  Copyright 2014-2020 Ahead WebSoft Technologies Pvt. Ltd.
 * @license    https://socialnetworking.solutions/license/
 * @version    $Id: Controller.php 2016-07-23 00:00:00 socialnetworking.solutions $
 * @author     socialnetworking.solutions
 */
class Sesblog_Widget_FeaturedSponsoredVerifiedCategorySlideshowController extends Engine_Content_Widget_Abstract {

  public function indexAction() {
  
    $this->view->socialshare_enable_plusicon = $this->_getParam('socialshare_enable_plusicon', 1);
    $this->view->socialshare_icon_limit = $this->_getParam('socialshare_icon_limit', 2);
    $this->view->allParams = $this->_getAllParams();
  	$value['category_id'] = $this->_getParam('category','');
    $this->view->title_truncation = $this->_getParam('title_truncation', '45');
	 	$this->view->isfullwidth = $this->_getParam('isfullwidth',1);
	 	$this->view->autoplay = $this->_getParam('autoplay',1);
		$this->view->speed = $this->_getParam('speed',2000);
		$this->view->type = $this->_getParam('type','fade');
		$this->view->navigation = $this->_getParam('navigation','buttons');
		$this->view->height = $this->_getParam('height','400');
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->viewer_id = $viewer->getIdentity();

    $show_criterias = isset($params['show_criterias']) ? $params['show_criterias'] : $this->_getParam('show_criteria', array('like', 'comment', 'title', 'socialSharing', 'view', 'featuredLabel', 'sponsoredLabel', 'verifiedLabel', 'rating', 'ratingStar', 'by', 'favourite','description','category','favouriteButton','likeButton', 'creationDate', 'readtime'));
    foreach ($show_criterias as $show_criteria)
      $this->view->{$show_criteria . 'Active'} = $show_criteria;		
    $limit =  $this->_getParam('limit_data', 5);
    $value['criteria'] = $this->_getParam('criteria', 5);
    $value['info'] = $this->_getParam('info', 'recently_created');
   	$value['order'] = $this->_getParam('order', '');
    $value['fetchAll'] = true;
		$value['limit'] = $limit;
    $this->view->paginator = $paginator = Engine_Api::_()->getDbTable('blogs', 'sesblog')->getSesblogsSelect($value);
		if (count($paginator) <= 0)
			return $this->setNoRender();
  }
}
