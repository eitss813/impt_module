<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Event
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @access	   John
 */
?>

<ul class="generic_list_widget" id="events-upcoming">
  <?php foreach( $this->paginator as $event ):
    // Convert the dates for the viewer
    $startDateObject = new Zend_Date(strtotime($event->starttime));
    $endDateObject = new Zend_Date(strtotime($event->endtime));
    if( $this->viewer() && $this->viewer()->getIdentity() ) {
      $tz = $this->viewer()->timezone;
      $startDateObject->setTimezone($tz);
      $endDateObject->setTimezone($tz);
    }
    $isOngoing = ( $startDateObject->toValue() < time() );
    ?>
    <li<?php if( $isOngoing ):?> class="ongoing"<?php endif ?>>
      <div class="photo">
        <?php echo $this->htmlLink($event->getHref(), $this->itemPhoto($event, 'thumb.icon', array('class' => 'thumb'))) ?>
      </div>
      <div class="info">
        <div class="title">
          <?php echo $event->__toString() ?>
        </div>
        <div class="stats">
          <div class="events-upcoming-date">
            <?php echo $this->timestamp($event->starttime, array('class'=>'eventtime')) ?>
          </div>
          <?php if( $isOngoing ): ?>
          <div class="events-upcoming-ongoing">
            <?php echo $this->translate('Ongoing') ?>
          </div>
          <?php endif; ?>
        </div>
      </div>
    </li>
  <?php endforeach; ?>
</ul>

<?php if( $this->paginator->getPages()->pageCount > 1 ): ?>
  <?php echo $this->partial('_widgetLinks.tpl', 'core', array(
    'url' => $this->url(array(), 'event_general', true)
    )); ?>
<?php endif; ?>
