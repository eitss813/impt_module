<?php if (count($this->navigation)): ?>
<div class='seaocore_admin_tabs'>
    <?php echo $this->navigation()->menu()->setContainer($this->navigation)->render(); ?>
</div>
<?php endif; ?>
<div class='clear siteevent_settings_form'>
    <div class='settings'>
        <?php echo $this->form->render($this) ?>
    </div>
</div>