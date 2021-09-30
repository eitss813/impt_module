<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Sitecrowdfunding
 * @copyright  Copyright 2017-2021 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: edit.tpl 2017-03-27 9:40:21Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
?>
<?php  if($this->layoutType != 'fundingDetails'): ?>
<?php include_once APPLICATION_PATH . '/application/modules/Sitecrowdfunding/views/scripts/_DashboardNavigation.tpl'; ?>
<?php endif; ?>

<div class="sitecrowdfunding_dashboard_content">
    <?php if($this->layoutType != 'fundingDetails'): ?>
        <?php echo $this->partial('application/modules/Sitecrowdfunding/views/scripts/dashboard/header.tpl', array('project' => $this->project)); ?>
    <?php endif; ?>
    <div class="sitecrowdfunding_project_form">
        <?php echo $this->form->render(); ?>
    </div>  
</div>
</div>
</div>
<?php
$src = '';
if ($this->reward && $this->reward->photo_id) {
    $src = Engine_Api::_()->storage()->get($this->reward->photo_id, '')->getPhotoUrl();
}
?>
<script>
    var disableFields = parseInt("<?php echo $this->disableFields ?>");
    var selectedCountries = JSON.decode('<?php echo json_encode($this->selectedCountries) ?>');
    var countriesAmount = JSON.decode('<?php echo json_encode($this->countriesAmount) ?>');
    window.addEvent('domready', function () {
        $('delivery_date-day').hide();
        var values = [];
        $('delivery_date-year').getElements('option').each(function (elem) {
            values.push(elem.get('text'));

        });
        selectedVal = $('delivery_date-year').value;
        values.sort();
        $('delivery_date-year').empty();
        $each(values, function (value) {
            new Element('option')
                    .set('text', value)
                    .set('value', value)
                    .inject($('delivery_date-year'));
        });
        $('delivery_date-year').value = selectedVal;
        populateQuantity();
        populateLocation();
        if (disableFields)
            disableElements();

        src = '<?php echo $src; ?>';
        if (src.length>0) {
            var rewardImg = new Element('img', {
                'src': src,
                'width': '25px',
                'height': '25px',
            });
            rewardImg.inject($('photo-element'));
        }
    });
    var AddLocation = function () {
        this.locations = JSON.decode('<?php echo json_encode($this->location); ?>');
        this.selectedLocations = new Array();
        this.parentElement = $('shipping_method').getParent();
        this.initiate = function () {
            this.selectedLocations = new Array();
            if ($$('.shipRow')) {
                $$('.shipRow').each(function (item, index) {
                    item.destroy();
                }
                );
            }
            if ($('addLocationLink'))
                $('addLocationLink').destroy();
        }
        this.addRow = function () {
            var row = this.createRow();
            if ($('addLocationLink')) {
                row.inject($('addLocationLink'), 'before');
            }
            else {
                row.inject(this.parentElement);
            }
        }
        this.restCountryRow = function () {
            var row = new Element('div', {
                'class': 'shipRow'
            });
            var div2 = new Element('div', {
                'class': 'shiprow_div2'

            });
            var locationElement = new Element('input', {
                'type': 'hidden',
                'name': 'locationsArray[]',
                'class': 'location',
                'value': '1'
            });
            var cNameDiv = new Element('div', {
                'class': 'cName',
                'text': 'Rest of World',
                'style': 'display:inline;'
            });
            var amountElement = new Element('input', {
                'type': 'text',
                'placeholder': 'Shipping Charge',
                'name': 'shippingAmountsArray[]',
                'class': 'amount',
                'onkeypress': 'return addLocationObj.checkAmount(event,$(this))'
            });
            locationElement.inject(row);
            cNameDiv.inject(div2);
            amountElement.inject(div2);
            div2.inject(row);
            row.inject(this.parentElement);
        }
        this.createRow = function () {
            var div = new Element('div', {
                'class': 'shipRow'
            });
            var div1 = new Element('div', {
                'class': 'shiprow_div1'

            });
            var div2 = new Element('div', {
                'class': 'shiprow_div2',
                'style': 'display:none;',
            });
            var locationElement = new Element('select', {
                'type': 'text',
                'name': 'locationsArray[]',
                'class': 'location active',
                'onchange': 'addLocationObj.selectCountry($(this))'
            });
            var cNameDiv = new Element('div', {
                'class': 'cName',
                'style': 'display:inline;'
            });
            var amountElement = new Element('input', {
                'type': 'text',
                'placeholder': 'Shipping Charge',
                'name': 'shippingAmountsArray[]',
                'class': 'amount',
                'onkeypress': 'return addLocationObj.checkAmount(event,$(this))'
            });
            var deleteImgElement = new Element('img', {
                'name': 'delete',
                'src': '<?php echo $this->layout()->staticBaseUrl ?>application/modules/Sitecrowdfunding/externals/images/region_enable0.gif',
                'onclick': "addLocationObj.deleteRow($(this))"
            });
            this.getShippingOption(locationElement);
            locationElement.inject(div1);
            cNameDiv.inject(div2);
            amountElement.inject(div2);
            deleteImgElement.inject(div2);
            div1.inject(div);
            div2.inject(div);
            return div;
        }
        this.checkAmount = function (evt, obj) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode == 46) {
                var inputValue = obj.value;
                var count = (inputValue.match(/'.'/g) || []).length;
                if (count < 1) {
                    if (inputValue.indexOf('.') < 1) {
                        return true;
                    }
                    return false;
                } else {
                    return false;
                }
            }
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        this.deleteRow = function (obj) {
            val = obj.getParent().getChildren()[0].value;
            if (val != '0') {
                this.selectedLocations.erase(val)
            }
            obj.getParent().destroy();
            parentObj = this;
            $$(".active").each(function (item, index) {
                item.options.length = 0;
                parentObj.getShippingOption(item);
            });
        }
        this.changeShippingOption = function (val) {

            this.initiate();
            if (val <= 1) {
                return false;
            }
            else if (val == 3) {
                this.restCountryRow();
            }
            this.addRow();
            var addLocationLink = new Element('div', {
                'class': 'addLocationLink',
                'id': 'addLocationLink',
                'text': 'Add another location',
                'onclick': 'addLocationObj.addRow()'
            });
            addLocationLink.inject(this.parentElement);
        }
        this.getShippingOption = function (obj) {
            new Element("option", {
                'text': "Select a location",
                'value': "0"
            }).inject(obj);
            selectedLocations = this.selectedLocations;
            Object.each(this.locations, function (item, index) {
                if (selectedLocations.indexOf(index) < 0) {
                    new Element("option", {
                        'text': item,
                        'value': index
                    }).inject(obj);
                }

            });

        }
        this.selectCountry = function (obj) {
            if (obj.getSelected().get('value') != 0) {
                obj.getParent().getNext().setStyle('display', 'block');
            }
            obj.getParent().getNext().getChildren()[0].innerHTML = obj.getSelected().get('text');
            this.selectedLocations[this.selectedLocations.length + 1] = obj.value;
            obj.removeClass("active");
            obj.addClass("hide");
            obj.hide();
            parentObj = this;
            $$(".active").each(function (item, index) {
                item.options.length = 0;
                parentObj.getShippingOption(item);
            });
        }
    }
    function checkQuantity() {
        if ($('limit').checked) {
            $('quantity-wrapper').show();
        } else {
            $('quantity-wrapper').hide();
        }
    }
    checkQuantity();
    var addLocationObj = new AddLocation();

    function populateQuantity() {
        if ($('quantity').value != 0) {
            $('limit').checked = true;
            checkQuantity();
        }
    }

    function populateLocation() {
        var val = $('shipping_method').value;
        addLocationObj.changeShippingOption(val);

        selectedCountries.each(function (item, index) {
            shipRow = $$('.shipRow')[index];
            select = shipRow.getElement('select.location');
            amount = shipRow.getElement('input.amount');
            amount.value = countriesAmount[index];
            if (select)
            {
                option = select.getElement('option[value=' + item + ']');
                option.selected = true;
                addLocationObj.selectCountry(select);
            }

            var limit = 1;
            if (val == 3)
                limit = 2;

            if (index < selectedCountries.length - limit)
                addLocationObj.addRow();

        })
    }

    function disableElements() {
        $('shipping_method-wrapper').hide();
        $('delivery_date-wrapper').hide();
        $('pledge_amount-wrapper').hide();
        $('quantity-wrapper').hide();
        $('limit-wrapper').hide();
        $('addLocationLink').hide();
    }


</script>


<!--    $logoValue = '';
        if ($this->_item && $this->_item->photo_id) {
            $url = Engine_Api::_()->storage()->get($this->_item->photo_id, '')->getPhotoUrl();
            $urlArr = explode("/", $url);
            $logo_name = explode("?c=", $urlArr[count($urlArr) - 1]);
            $logoValue = "[ Uploaded file " . $logo_name[0] . " ] &nbsp;&nbsp;<img src='$url' width=25px height=25px />";
        }-->