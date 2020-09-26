var boxBinding = new Shiny.OutputBinding();

createElement = function(row){
  var div = document.createElement('DIV');
  div.classList = 'level-item has-text-centered';

  div.innerHTML = '<div><p class="heading">' + row.title + '</p><p class="title">' + row.value + '</p></div>';

  return div;
}

$.extend(boxBinding, {
  find: function(scope) {
    return $(scope).find(".box");
  },
  renderValue: function(el, data) {

    let base_url = window.location.href;
    let url = base_url  + data;

    console.log(url);
    console.log(data);

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

Shiny.outputBindings.register(boxBinding, "pharma.box");
