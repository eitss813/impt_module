<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php /*
<h3>
  <?php echo $this->poll->title ?>
</h3>
  */ ?>

<div class="poll_desc">
  <?php echo $this->poll->description ?>
</div>

<?php
  // poll, pollOptions, canVote, canChangeVote, hasVoted, showPieChart
  $this->hideStats = true;
  echo $this->render('application/modules/Poll/views/scripts/_poll.tpl')
?>

<span class="poll_view_single">
  <div class="poll_stats">
    <?php echo $this->htmlLink($this->poll->getHref(), $this->translate('View')) ?>
    <?php /*
    <br />
    <span class="poll_vote_total">
      <?php echo $this->translate(array('%s vote', '%s votes', $this->poll->vote_count), $this->locale()->toNumber($this->poll->vote_count)) ?>
    </span>
    &nbsp;|&nbsp;
    <?php echo $this->translate(array('%s view', '%s views', $this->poll->view_count), $this->locale()->toNumber($this->poll->view_count)) ?>
     *
     */ ?>
  </div>
</span>
