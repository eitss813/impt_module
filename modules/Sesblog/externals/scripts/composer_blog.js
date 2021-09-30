/* $Id: composer_blog.js 9930 2013-02-18 21:02:11Z jung $ */
(function() { // START NAMESPACE
var $ = 'id' in document ? document.id : window.$;
Composer.Plugin.Sesblog = new Class({

  Extends : Composer.Plugin.Interface,

  name : 'sesblog',

  options : {
    title : 'Write New Blog',
		url:'',
    lang : {}
  },

  initialize : function(options) {
    this.elements = new Hash(this.elements);
    this.params = new Hash(this.params);
    this.parent(options);
  },

  attach : function() {
    this.parent();
    this.makeActivator();
		sesJqueryObject('#compose-sesblog-activator').addClass('sessmoothbox').attr('href','javascript:;').attr('data-url',this.options.requestOptions.url);
    return this;
  },

  detach : function() {
    this.parent();
    return this;
  },

  activate : function() {
    if( this.active ) return;
    this.parent();
		this.getComposer().getMenu().getElements('.compose-activator').each(function(element) {
      element.setStyle('display', '');
    });
  },
	deactivate: function() {
      if (!this.active)
        return;
      this.parent();
    }
});



})(); // END NAMESPACE
