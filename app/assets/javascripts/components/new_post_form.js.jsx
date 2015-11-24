var NewPostForm = NewPostForm || {};

(function() {
  "use strict";
  NewPostForm = React.createClass({

    getInitialState: function() {
      return {
        key: Immutable.Map({isActive: false, value: "", validationMessage: ""})
      };
    },

    render: function() {
      var keyValidationMessageClass = this.state.key.get('isActive') ? "text-success" : "text-danger";
      return (
        <div>
          <label className="col-md-1" htmlFor="key">Key</label>
          <div className="col-sm-3">
            <input type="text" value={this.state.key.get('value')} onChange={this._onKeyChange} className="form-control" id="key" />
            <div className={keyValidationMessageClass}>{this.state.key.get('validationMessage')}</div>
          </div>
        </div>
      );
    },

    _onKeyChange: function(event) {
      var that = this;
      var key = event.target.value;
      var goodKeyMessage = "Good Key!";
      var badKeyMessage = "Bad Key :(";
      if (key.length >= 4) {
        $.ajax({
          url: "/posts/validate_key",
          type: "GET",
          data: {key: key},
          success: function(response) {
            var validationMessage = response.isActive ? goodKeyMessage : badKeyMessage;
            that.setState({
              key: Immutable.Map({
                value: response.key,
                isActive: response.isActive,
                validationMessage: validationMessage,
              })
            });
          },
          error: function(response) {
            //handle error
          }
        });
      } else {
        that.setState({
          key: Immutable.Map({
            value: key,
            isActive: false,
            validationMessage: badKeyMessage,
          })
        });
      }
    },
  });
})();
