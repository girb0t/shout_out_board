var NewUserForm = NewUserForm || {};

(function() {
  "use strict";
  NewUserForm = React.createClass({
    endpoints: {
      submitForm: '/users'
    },

    getInitialState: function() {
      return {
        firstName: '',
        lastName: '',
        email: '',
        username: '',
        password: '',
        passwordConfirmation: '',
      };
    },

    render: function() {
      return (
        <div>
          <form role="form" className="form-horizontal">
            {/* first name */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="first-name-input">First Name</label>
              <div className="col-sm-3">
                <input value={this.state.firstName} type="text" onChange={this._onFirstNameChange} className="form-control" id="first-name-input" />
              </div>
            </div>
            {/* last name */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="last-name-input">Last Name</label>
              <div className="col-sm-3">
                <input value={this.state.lastName} type="text" onChange={this._onLastNameChange} className="form-control" id="last-name-input" />
              </div>
            </div>
            {/* email */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="email-input">Email</label>
              <div className="col-sm-3">
                <input value={this.state.email} type="text" onChange={this._onEmailChange} className="form-control" id="email-name-input" />
              </div>
            </div>
            {/* username */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="username-input">Username</label>
              <div className="col-sm-3">
                <input value={this.state.username} type="text" onChange={this._onUsernameChange} className="form-control" id="username-input" />
              </div>
            </div>
            {/* password */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="password-input">Password</label>
              <div className="col-sm-3">
                <input value={this.state.password} type="password" onChange={this._onPasswordChange} className="form-control" id="password-input" />
              </div>
            </div>
            {/* comfirm password */}
            <div className="form-group">
              <label className="col-sm-1 col-md-1" htmlFor="confirm-password-input">Confirm Password</label>
              <div className="col-sm-3">
                <input value={this.state.passwordConfirmation} type="password" onChange={this._onConfirmPasswordChange} className="form-control" id="confirm-password-input" />
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
      form.submit();
    },

    _onFirstNameChange: function(event) {
      this.setState({
        firstName: event.target.value,
      });
    },

    _onLastNameChange: function(event) {
      this.setState({
        lastName: event.target.value,
      });
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
        passwordConfirmation: event.target.value,
      });
    }
  });
})();
