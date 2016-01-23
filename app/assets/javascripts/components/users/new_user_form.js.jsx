var NewUserForm = NewUserForm || {};

(function() {
  "use strict";
  NewUserForm = React.createClass({
    endpoints: {
      submitForm: '/users'
    },

    getInitialState: function() {
      return {
        username: '',
        email: '',
        password: '',
        confirmPassword: '',
      };
    },

    render: function() {
      return (
        <div>
          <form role="form" className="form-horizontal">
            {/* email */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="email-input">Email</label>
              <div className="col-sm-3">
                <input type="text" onChange={this._onEmailChange} className="form-control" id="email-input" />
              </div>
            </div>
            {/* username */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="username-input">Username</label>
              <div className="col-sm-3">
                <input type="text" onChange={this._onUsernameChange} className="form-control" id="username-input" />
              </div>
            </div>
            {/* password */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="password-input">Password</label>
              <div className="col-sm-3">
                <input type="password" onChange={this._onPasswordChange} className="form-control" id="password-input" />
              </div>
            </div>
            {/* comfirm password */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="confirm-password-input">Confirm Password</label>
              <div className="col-sm-3">
                <input type="password" onChange={this._onConfirmPasswordChange} className="form-control" id="confirm-password-input" />
              </div>
            </div>

            <button className="btn btn-primary" type="button" onClick={this._onSubmit}>Submit</button>
          </form>
        </div>
      );
    },

    _onSubmit: function() {
      console.log(this.state);
      var form = $('form.new-user-form-data');
      var jsonInputField= form.find('#form-data-json');
      var url = this.endpoints.submitForm;

      form.attr('action', url);
      jsonInputField.val(JSON.stringify(Immutable.fromJS(this.state).toJS()));
      form.sumbit();
    },

    _onEmailChange: function(event) {
      this.setState({
        email: event.target.value,
      });
    },

    _onUsernameChange: function(event) {
      this.setState({
        username: event.target.value,
      });
    },

    _onPasswordChange: function(event) {
      this.setState({
        password: event.target.value,
      });
    },

    _onConfirmPasswordChange: function(event) {
      this.setState({
        confirmPassword: event.target.value,
      });
    }
  });
})();
