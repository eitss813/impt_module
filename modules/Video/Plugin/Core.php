<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Video_Plugin_Core
{
  public function onStatistics($event)
  {
    $table   = Engine_Api::_()->getDbTable('videos', 'video');
    $select = new Zend_Db_Select($table->getAdapter());
    $select->from($table->info('name'), 'COUNT(*) AS count');
    $event->addResponse($select->query()->fetchColumn(0), 'video');
  }

  public function onUserDeleteBefore($event)
  {
    $payload = $event->getPayload();
    if( $payload instanceof User_Model_User ) {
      // Delete videos
      $videoTable = Engine_Api::_()->getDbtable('videos', 'video');
      $videoSelect = $videoTable->select()->where('owner_id = ?', $payload->getIdentity());
      foreach( $videoTable->fetchAll($videoSelect) as $video ) {
        Engine_Api::_()->getApi('core', 'video')->deleteVideo($video);
      }
    }
  }
}
