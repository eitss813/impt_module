<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Album.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Event_Model_Album extends Core_Model_Item_Collection
{
  protected $_parent_type = 'event';

  protected $_owner_type = 'event';

  protected $_children_types = array('event_photo');

  protected $_collectible_type = 'event_photo';

  public function getHref($params = array())
  {
    $params = array_merge(array(
      'route' => 'event_profile',
      'reset' => true,
      'id' => $this->getEvent()->getIdentity(),
      //'album_id' => $this->getIdentity(),
    ), $params);
    $route = $params['route'];
    $reset = $params['reset'];
    unset($params['route']);
    unset($params['reset']);
    return Zend_Controller_Front::getInstance()->getRouter()
      ->assemble($params, $route, $reset);
  }

  public function getEvent()
  {
    return $this->getOwner();
    //return Engine_Api::_()->getItem('event', $this->event_id);
  }

  public function getAuthorizationItem()
  {
    return $this->getParent('event');
  }

  protected function _delete()
  {
    // Delete all child posts
    $photoTable = Engine_Api::_()->getItemTable('event_photo');
    $photoSelect = $photoTable->select()->where('album_id = ?', $this->getIdentity());
    foreach( $photoTable->fetchAll($photoSelect) as $eventPhoto ) {
      $eventPhoto->delete();
    }

    parent::_delete();
  }
}
