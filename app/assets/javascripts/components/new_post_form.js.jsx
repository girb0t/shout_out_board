var NewPostForm = NewPostForm || {};

(function() {
  "use strict";
  NewPostForm = React.createClass({

    getInitialState: function() {
      return {
        key: Immutable.Map({isActive: false, value: "", validationMessage: ""}),
        categories: Immutable.List(),
      };
    },

    componentDidMount: function() {
      $('#key-input-container input').focus();
    },

    render: function() {
      var keyValidationMessageClass = this.state.key.get('isActive') ? "text-success" : "text-danger";
      return (
        <div>
          <div id="key-input-container" className="col-md-4 col-md-offset-4">
            <div className="">
              <input type="text"
                     value={this.state.key.get('value')}
                     onChange={this._onKeyChange}
                     className="form-control" id="key"
                     placeholder="Enter Key" />
              <div className={keyValidationMessageClass}>{this.state.key.get('validationMessage')}</div>
            </div>
          </div>

          <div id="post-form-container" className="col-md-8 col-md-offset-2">
            <ul className="nav nav-tabs">
              <li role="presentation" className="active"><a href="#">Home</a></li>
              <li role="presentation"><a href="#">Profile</a></li>
              <li role="presentation"><a href="#">Messages</a></li>
            </ul>
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
            var newState = ({
              key: Immutable.Map({
                     value: response.key,
                     isActive: response.isActive,
                     validationMessage: validationMessage,
                   }),
              categories: that.getInitialState().categories,
            });

            if(response.categories) {
              newState.categories = Immutable.fromJS(response.categories);
            }

            that.setState(newState);
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
