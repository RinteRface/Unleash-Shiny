var boxxyBinding = new Shiny.OutputBinding();

createElement = function(row){
  var div = document.createElement('DIV');
  div.classList = 'level-item has-text-centered';

  div.innerHTML = '<div><p class="heading">' + row.title + '</p><p class="title">' + row.value + '</p></div>';

  return div;
}

$.extend(boxxyBinding, {
  find: function(scope) {
    return $(scope).find(".boxxy");
  },
  renderValue: function(el, data) {

    let base_url = window.location.href;
    let url = base_url  + data.uri;

    console.log(url);
    console.log(data.uri);

    fetch(url)
      .then(response => response.json())
      .then(data => {
        data.map((row)=>{
          let div = createElement(row);
          $(el).append(div);
        })
      })

  }
});

Shiny.outputBindings.register(boxxyBinding, "john.boxxy");
