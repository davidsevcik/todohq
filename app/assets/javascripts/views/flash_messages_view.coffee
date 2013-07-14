App.FlashMesssagesView = Em.CollectionView.extend
  needs: ['flashMessages']
  content: Em.computed.oneWay 'controllers.flashMessages.content'


