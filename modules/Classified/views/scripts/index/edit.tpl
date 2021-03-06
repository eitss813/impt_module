<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2020 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: edit.tpl 10110 2013-10-31 02:04:11Z andres $
 * @author     Jung
 */
?>
<?php 
if(0) {
$spamSettings = Engine_Api::_()->getApi('settings', 'core')->core_spam;
$recaptchaVersionSettings = Engine_Api::_()->getApi('settings', 'core')->core_spam_recaptcha_version;
if($recaptchaVersionSettings == 0  && $spamSettings['recaptchaprivatev3'] && $spamSettings['recaptchapublicv3']) { ?>
  <script type="text/javascript"
    src="https://www.google.com/recaptcha/api.js?render=<?php echo $spamSettings['recaptchapublicv3']; ?>">
  </script>
  <script type="text/javascript">
    grecaptcha.ready(function () {
      grecaptcha.execute('<?php echo $spamSettings['recaptchapublicv3']; ?>', { action: 'login' }).then(function (token) {
        var recaptchaResponse = document.getElementById('recaptchaResponse');
        recaptchaResponse.value = token;
      });
    });
  </script>
<?php } } ?>
<?php
  if (APPLICATION_ENV == 'production')
    $this->headScript()
->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.min.js');
else
$this->headScript()
->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Observer.js')
->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.js')
->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.Local.js')
->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Autocompleter.Request.js');
?>

<script type="text/javascript">
    en4.core.runonce.add(function()
    {
        new Autocompleter.Request.JSON('tags', '<?php echo $this->url(array('controller' => 'tag', 'action' => 'suggest'), 'default', true) ?>', {
        'postVar' : 'text',

        'minLength': 1,
        'selectMode': 'pick',
        'autocompleteType': 'tag',
        'className': 'tag-autosuggest',
        'filterSubset' : true,
        'multiple' : true,
        'injectChoice': function(token){
            var choice = new Element('li', {'class': 'autocompleter-choices', 'value':token.label, 'id':token.id});
            new Element('div', {'html': this.markQueryValue(token.label),'class': 'autocompleter-choice'}).inject(choice);
            choice.inputValue = token;
            this.addChoiceclassifieds(choice).inject(this.choices);
            choice.store('autocompleteChoice', token);
        }
    });
    });
</script>

<?php
  /* Include the common user-end field switching javascript */
  echo $this->partial('_jsSwitch.tpl', 'fields', array(
//'topLevelId' => (int) @$this->topLevelId,
//'topLevelValue' => (int) @$this->topLevelValue
))
?>
<div class="layout_middle">
  <div class="generic_layout_container">
      <div class="headline">
        <h2>
          <?php echo $this->translate('Classified Listings');?>
        </h2>
        <div class="tabs">
          <?php
            // Render the menu
            echo $this->navigation()
          ->menu()
          ->setContainer($this->navigation)
          ->render();
          ?>
        </div>
     </div>
  </div>
</div>
<div class="layout_middle">
  <div class="generic_layout_container">
<form action="<?php echo $this->escape($this->form->getAction()) ?>" method="<?php echo $this->escape($this->form->getMethod()) ?>" class="global_form classifieds_browse_filters">
  <div>
    <div>
      <h3>
        <?php echo $this->translate($this->form->getTitle()) ?>
      </h3>

      <div class="form-elements">
        <?php echo $this->form->getDecorator('FormErrors')->setElement($this->form)->render("");?>
        <?php echo $this->form->title; ?>
        <?php echo $this->form->tags; ?>
        <?php if($this->form->category_id) echo $this->form->category_id; ?>
        <?php echo $this->form->body; ?>
        <?php echo $this->form->getSubForm('fields'); ?>
        <?php if($this->form->networks) echo $this->form->networks; ?>
        <?php if($this->form->auth_view) echo $this->form->auth_view; ?>
        <?php if($this->form->auth_comment) echo $this->form->auth_comment; ?>

      </div>

      <?php echo $this->form->classified_id; ?>
      <ul class='classifieds_editphotos'>
        <?php foreach( $this->paginator as $photo ): ?>
        <li>
          <div class="classifieds_editphotos_photo">
            <?php echo $this->itemPhoto($photo, 'thumb.normal')  ?>
          </div>
          <div class="classifieds_editphotos_info">
            <?php
                $key = $photo->getGuid();
            echo $this->form->getSubForm($key)->render($this);
            ?>
            <div class="classifieds_editphotos_cover">
              <input type="radio" name="cover" value="<?php echo $photo->getIdentity() ?>" <?php if( $this->classified->photo_id == $photo->file_id ): ?> checked="checked"<?php endif; ?> />
            </div>
            <div class="classifieds_editphotos_label">
              <label><?php echo $this->translate('Main Photo');?></label>
            </div>
          </div>
        </li>
        <?php endforeach; ?>
      </ul>
      <?php echo $this->form->execute->render(); ?>

      </div>
    </div>
  </form>
 </div>
</div>
<script type="application/javascript">
  window.addEvent('load', function() {
    scriptJquery('.classified_photos').each(function(){ 
      tinymce.execCommand('mceRemoveEditor',true, scriptJquery(this).attr('id'));
    });
  });
</script>
<?php if( $this->paginator->count() > 0 ): ?>
<br />
<?php echo $this->paginationControl($this->paginator); ?>
<?php endif; ?>
