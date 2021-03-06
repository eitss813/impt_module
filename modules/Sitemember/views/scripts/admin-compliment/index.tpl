<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Sitemember
 * @copyright  Copyright 2015-2016 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: index.tpl 6590 2016-07-07 00:00:00Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
?>
<!--ADD NAVIGATION-->
<?php if (count($this->navigation)): ?>
  <div class='tabs'>
    <?php echo $this->navigation()->menu()->setContainer($this->navigation)->render(); ?>
  </div>
<?php endif; ?>
<?php if( count($this->subNavigation) ): ?>
  <div class='seaocore_admin_tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->subNavigation)->render()
    ?>
  </div>
<?php endif; ?>
<h3>
  <?php echo $this->translate("Manage Compliment Icons"); ?>
</h3>
<p>
  <?php echo $this->translate("From this page, you can manage and re-order the compliment icons. Drag and drop items to arrange their sequence. You can assign a higher positioning to compliment icon that are more important for your community. Also, you can add a new compliment icon and set the member level settings below."); ?> 
</p>
<br />
<div>
  <a href="<?php echo $this->url(array('action' => 'add')) ?>" class="buttonlink seaocore_icon_add" title="<?php echo $this->translate('Add a Compliment Icon'); ?>"><?php echo $this->translate('Add a Compliment Icon'); ?></a>
  
   <a href="<?php echo $this->url(array('action' => 'level')) ?>" class="buttonlink seaocore_icon_edit" title="<?php echo $this->translate('Manage Level Settings'); ?>"><?php echo $this->translate('Manage Level Settings'); ?></a>
</div>
<br />
<div class="seaocore_admin_order_list">
  <div class="list_head">
    <div style="width:40%">
      <?php echo $this->translate("Title"); ?>
    </div>
    <div style="width:40%">
      <?php echo $this->translate("Icon"); ?>
    </div> 
    <div style="width:10%">
      <?php echo $this->translate("Options"); ?>
    </div>
  </div>

  <form id='saveorder_form' method='post' action='<?php echo $this->url(array('action' => 'update-order')) ?>'>
    <input type='hidden'  name='order' id="order" value=''/>
    <div id='order-element'>      
      <ul>
        <?php foreach ($this->complimentIcons as $item) : ?>
          <li>
            <input type='hidden'  name='order[]' value='<?php echo $item->complimentcategory_id; ?>'>
            <div style="width:40%;" class='admin_table_bold'>
              <?php echo $item->getTitle(true); ?>
            </div>
            
            <div style="width:40%;" class='admin_table_bold'>
              <?php echo $this->itemPhoto($item, 'thumb.icon', '', array(
                'align' => 'center'))
              ?>
            </div>
            <div style="width:10%;">
              <a href='<?php echo $this->url(array('action' => 'edit', 'complimentcategory_id' => $item->complimentcategory_id)) ?>'>
              <?php echo $this->translate("Edit") ?>
              </a>
                |
              
                <a href='<?php echo $this->url(array('action' => 'delete', 'complimentcategory_id' => $item->complimentcategory_id)) ?>' class="smoothbox">
                <?php echo $this->translate("Delete") ?>
                </a>
              
            </div>
          </li>
<?php endforeach; ?>
      </ul>
    </div>
  </form>
  <br />
  <?php if(count($this->complimentIcons)>1) : ?>
  <button onClick="javascript:saveOrder(true);" type='submit'>
<?php echo $this->translate("Save Order") ?>
  </button>
<?php endif; ?>
</div>
<script type="text/javascript">

  var saveFlag = false;
  var origOrder;
  var changeOptionsFlag = false;

  function saveOrder(value) {
    saveFlag = value;
    var finalOrder = [];
    var li = $('order-element').getElementsByTagName('li');
    for (i = 1; i <= li.length; i++)
      finalOrder.push(li[i]);
    $("order").value = finalOrder;

    $('saveorder_form').submit();
  }
  window.addEvent('domready', function() {
    //         We autogenerate a list on the fly
    var initList = [];
    var li = $('order-element').getElementsByTagName('li');
    for (i = 1; i <= li.length; i++)
      initList.push(li[i]);
    origOrder = initList;
    var temp_array = $('order-element').getElementsByTagName('ul');
    temp_array.innerHTML = initList;
    new Sortables(temp_array);
  });

  window.onbeforeunload = function(event) {
    var finalOrder = [];
    var li = $('order-element').getElementsByTagName('li');
    for (i = 1; i <= li.length; i++)
      finalOrder.push(li[i]);



    for (i = 0; i <= li.length; i++) {
      if (finalOrder[i] != origOrder[i])
      {
        changeOptionsFlag = true;
        break;
      }
    }

    if (changeOptionsFlag == true && !saveFlag) {
      var answer = confirm("<?php echo $this->string()->escapeJavascript($this->translate("A change in the order of the tabs has been detected. If you click Cancel, all unsaved changes will be lost. Click OK to save change and proceed.")); ?>");
      if (answer) {
        $('order').value = finalOrder;
        $('saveorder_form').submit();

      }
    }
  }
</script>
