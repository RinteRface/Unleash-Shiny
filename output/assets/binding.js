// create level item
createLevelItem = function(row){
  var div = document.createElement('DIV');
  div.classList = 'level-item has-text-centered';

  div.innerHTML = '<div><p class="heading">' + row.title + '</p><p class="title">' + row.value + '</p></div>';

  return div;
}

// binding
var boxBinding = new Shiny.OutputBinding();

$.extend(boxBinding, {
  find: function(scope) {
    return $(scope).find(".box");
  },
  renderValue: function(el, data) {

  }
});

Shiny.outputBindings.register(boxBinding, "pharma.box");
