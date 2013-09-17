var  Messages = (function(){

  var input, template, url, interval, placeholder;

  var createMessage = function(args){
    ajax({
      method: 'POST',
      url: args.url,
      data: args.message,
      success: args.success
    });
  };

  var ajax = function(args) {
    var data = JSON.stringify(args.data);
    var success = typeof args.success !== 'undefined' ? args.success : function(){};
    xhr = new XMLHttpRequest();
    xhr.open(args.method, args.url, true);
    xhr.responseType = 'json';
    xhr.setRequestHeader('Content-type', 'application/json');
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.onload = function(){
      var data;

      switch(xhr.status) {
        case 201:
          data = null;
          break;
        case 200:
          data = JSON.parse(xhr.responseText);
          break;
      }
      success(data, xhr);
    };
    if(data !== undefined){
      xhr.send(JSON.stringify(args.data));
    } else {
      xhr.send();
    }
  };

  var getMessages = function(args){
    var placeholder = args.placeholder;
    ajax({
      method: 'GET',
      url: args.url,
      success: function(data, xhr){
        new_messages = args.template(data);
        placeholder.insertAdjacentHTML('beforeend', new_messages);
        placeholder.scrollTop = placeholder.scrollHeight;
      }
    });

  };

  bindEnter =  function(el) {
    el.addEventListener("keyup", function(evt) {
      if(evt.keyCode === 13){
        createMessage({
          url: url,
          message: { body: el.value },
          success: function(data){
            el.value = "";
          }
        });

      }
    }, false);
  };

  return {
    init: function(params){
      var args = params;
      var template = Handlebars.compile(params.template.innerText);
      url = args.url;
      bindEnter(args.input);
      this.interval = window.setInterval(function(){
        getMessages({
          url: args.url,
          template: template,
          placeholder: args.placeholder
        });
      }, 3000 );
    }
  };
})();

