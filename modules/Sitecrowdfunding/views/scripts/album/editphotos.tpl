<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Sitecrowdfunding
 * @copyright  Copyright 2017-2021 BigStep Technologies Pvt. Ltd.
 * @license    http://www.socialengineaddons.com/license/
 * @version    $Id: editphotos.tpl 2017-03-27 9:40:21Z SocialEngineAddOns $
 * @author     SocialEngineAddOns
 */
?>

<?php include_once APPLICATION_PATH . '/application/modules/Sitecrowdfunding/views/scripts/_DashboardNavigation.tpl'; ?>
<div class="sitecrowdfunding_dashboard_content">
    <?php echo $this->partial('application/modules/Sitecrowdfunding/views/scripts/dashboard/header.tpl', array('project' => $this->project, 'sectionTitle' => 'Edit Project Photos', 'sectionDescription' => 'Edit and manage the photos of your project below.')); ?>
    <div class="sitecrowdfunding_dashboard_form">
        <div class="global_form">
            <div>
                <div>
                    <!--<h3><?php echo $this->translate("Edit Project Photos"); ?></h3>
                    <p class="form-description"><?php echo $this->translate("Edit and manage the photos of your project below."); ?> -->
                    <div class="clr">
                        <?php echo $this->htmlLink(array('route' => "sitecrowdfunding_photoalbumupload", 'album_id' => $this->album_id, 'project_id' => $this->project_id), $this->translate('Add New Photos'), array('class' => 'icon seaocore_icon_add')) ?>
                    </div>
                    <?php if ($this->paginator->count() > 0): ?>
                    <?php echo $this->paginationControl($this->paginator); ?>
                    <?php endif; ?>
                    <form action="<?php echo $this->escape($this->form->getAction()) ?>" method="<?php echo $this->escape($this->form->getMethod()) ?>">
                        <?php echo $this->form->album_id; ?>
                        <ul class='sitecrowdfunding_edit_media' id="photo">
                            <?php if (!empty($this->count)): ?>
                            <?php foreach ($this->paginator as $photo): ?>
                            <li>
                                <div class="sitecrowdfunding_edit_media_thumb"> <?php echo $this->itemPhoto($photo, '') ?> </div>
                                <div class="sitecrowdfunding_edit_media_info">
                                    <?php
                                            $key = $photo->getGuid();
                                    echo $this->form->getSubForm($key)->render($this);
                                    ?>
                                    <div class='sitecrowdfunding_edit_media_options'>
                                        <div class="sitecrowdfunding_edit_media_options_check fleft">
                                            <input id="main_photo_id_<?php echo $photo->photo_id ?>" type="radio" name="cover" value="<?php echo $photo->file_id ?>" <?php if ($this->project->photo_id == $photo->file_id): ?> checked="checked"<?php endif; ?> />
                                        </div>
                                        <div class="sitecrowdfunding_edit_media_options_label fleft">
                                            <label for="main_photo_id_<?php echo $photo->photo_id ?>"><?php echo $this->translate('Main Photo'); ?></label>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <?php endforeach; ?>
                            <?php else: ?><br />
                            <div class="tip">
                                    <span>
                                        <?php $url = $this->url(array('project_id' => $this->project_id), 'sitecrowdfunding_photoalbumupload', true); ?>
                                        <?php echo $this->translate('There are currently no photos in this project. %1$sClick here%2$s to add photos now!', "<a href='$url'>", "</a>"); ?>
                                    </span>
                            </div>
                            <?php endif; ?>
                            <?php if (!empty($this->count)): ?>
                            <div class="sitecrowdfunding_edit_photos_button">
                                <?php echo $this->form->submit->render(); ?>
                            </div>
                            <?php endif; ?>
                        </ul>
                    </form>
                    <?php if ($this->paginator->count() > 0): ?>
                    <br />
                    <?php echo $this->paginationControl($this->paginator); ?>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>