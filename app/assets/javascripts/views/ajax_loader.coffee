App.AjaxLoader = Em.View.extend
  tagName: 'img'
  attributeBindings: 'src width height'.w()
  src: '/assets/ajax-loader.gif'
  width: 220
  height: 19
  classNames: 'loader'
