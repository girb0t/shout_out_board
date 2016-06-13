var NewBoardForm = NewBoardForm || {};

(function() {
  "use strict";
  NewBoardForm = React.createClass({
    endpoints: {
      validateKey: '/boards/validate_key',
      submitForm:  '/boards',
    },

    componentDidMount: function() {
      $('[data-toggle="tooltip"]').tooltip({placement: 'right', trigger: 'hover'});
    },

    getInitialState: function() {
      return {
        key: Immutable.Map({isValid: false, value: "", validationMessage:""}),
        title: Immutable.Map({title: "", validationMessage: ""}),
        categoryCount: 2,
        category1: Immutable.Map({title: "", prompt: "", tabName: "", validationMessage:""}),
        category2: Immutable.Map({title: "", prompt: "", tabName: "", validationMessage:""}),
        category3: Immutable.Map({title: "", prompt: "", tabName: "", validationMessage:""}),
      };
    },

    render: function() {
      var keyValidationMessageClass = this.state.key.get('isValid') ? "text-success" : "text-danger";
      var validationFailedMessageClass = "text-danger";

      return(
        <div>
          <h1>New Board</h1>
          <form role="form" className="form-horizontal" id="new-board-form">
            <div className="form-group">
              <label htmlFor="key">Board Key</label>
              <div className="input-container">
                <input type="text"
                  onChange={this.onKeyChange}
                  className="form-control"
                  id="key"
                  data-toggle="tooltip"
                  title="A key entered by students to post to a board." />
                <div className={keyValidationMessageClass}>{this.state.key.get('validationMessage')}</div>
              </div>
            </div>
            <div className="form-group">
              <label htmlFor="title">Board Title</label>
              <div className="input-container">
                <input ref="my-title" type="text" value={this.state.title.get('title')} onChange={this.onTitleChange} className="form-control" id="title" />
                <div className={validationFailedMessageClass}>{this.state.title.get('validationMessage')}</div>
              </div>
            </div>

            <div id="categories-section">
              <h3>Categories</h3>
              <hr/>
              <div className="form-group">
                <label htmlFor="category-count">Category Count</label>
                <div className="input-container">
                  <select value={this.state.categoryCount} id="category-count" onChange={this.onCategoryCountChange}>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                  </select>
                </div>
              </div>
              <hr/>
              {this.buildCategorySection()}
            </div>


            <button className="btn btn-primary" type="button" onClick={this.onSubmit}>Submit</button>
          </form>
        </div>
      );
    },

    onSubmit: function() {
      var formIsValid = false;
      formIsValid = this.validateKey();
      formIsValid = this.validateTitle();
      formIsValid = this.validateCategories();
      if (formIsValid) {
        var form = $('form.new-board-form-data');
        var jsonInputField = form.find('#form-data-json');
        var url = this.endpoints.submitForm;

        form.attr("action", url);
        jsonInputField.val(JSON.stringify(Immutable.fromJS(this.state).toJS()));
        form.submit();
      }
    },

    validateKey: function() {
      if (this.state.key.get('value').length === 0) {
        this.setState({key: this.state.key.set("validationMessage", "Key can't be blank.")});
        return false;
      } else {
        return this.state.key.get('isValid');
      }
    },

    validateTitle: function() {
      if (this.state.title.get("title").length === 0) {
        this.setState({title: this.state.title.set("validationMessage", "Title can't be blank.")});
        return false;
      } else {
        this.setState({title: this.state.title.set("validationMessage", "")});
        return true;
      }
    },

    validateCategories: function() {
      var isValid = true,
          newState = {},
          categoryObj;

      for (var i = 0; i < this.state.categoryCount; ++i) {
        categoryObj = this.state["category" + (i+1)];
        if (categoryObj.get("title").length === 0 || categoryObj.get("prompt").length === 0 || categoryObj.get("tabName").length === 0) {
          newState["category" + (i+1)] = categoryObj.set("validationMessage", "'Title', 'Tab Name', and 'Prompt' can't be blank.");
          isValid = false;
        } else {
          newState["category" + (i+1)] = categoryObj.set("validationMessage", "");
        }
      }
      this.setState(newState);
      return isValid;
    },

    onKeyChange: function(event) {
      var that = this;
      var key = event.target.value;
      if (key.length >= 4) {
        $.ajax({
          url: this.endpoints.validateKey,
          type: "GET",
          data: {key: key},
          success: function(response) {
            var validationMessage = response.isValid ? "Key is available!" : "Key already in use.";
            that.setState({
              key: Immutable.Map({
                value: response.key,
                isValid: response.isValid,
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
            isValid: false,
            validationMessage: "Key too short."
          })
        });
      }
    },

    onTitleChange: function(event) {
      this.setState({title: this.state.title.set('title', event.target.value)});
    },

    onCategoryCountChange: function(event) {
      this.setState({ categoryCount: parseInt(event.target.value) });
    },

    onCategoryTitleChange: function(name, event) {
      var newState = {};
      newState[name] = this.state[name].set('title', event.target.value);
      this.setState(newState);
    },

    onCategoryTabNameChange: function(name, event) {
      var newState = {};
      newState[name] = this.state[name].set('tabName', event.target.value);
      this.setState(newState);
    },

    onCategoryBodyChange: function(name, event) {
      var newState = {};
      newState[name] = this.state[name].set('prompt', event.target.value);
      this.setState(newState);
    },

    buildCategorySection: function() {
      var categoryId,
          titleId,
          titleText,
          tabNameId,
          tabNameText,
          bodyId,
          bodyText,
          categoryCount = this.state.categoryCount,
          categoryNodes = [];

      for (var i = 0; i < categoryCount; ++i) {
        categoryId = "category" + (i+1);
        titleId = categoryId + "-title";
        titleText = this.state[categoryId].get("title");
        tabNameId = categoryId + "-tab-name";
        tabNameText = this.state[categoryId].get("tabName");
        bodyId = categoryId + "-prompt";
        bodyText = this.state[categoryId].get("prompt");

        categoryNodes.push(
          <div key={categoryId}>
            <div className="text-danger">{this.state[categoryId].get('validationMessage')}</div>
            <br/>

            <div className="form-group">
              <label htmlFor={titleId}>Cat. {i + 1} Title</label>
              <div className="input-container">
                <input value={titleText} type="text" onChange={this.onCategoryTitleChange.bind(this, categoryId)} className="form-control" id={titleId} />
              </div>
            </div>
            <div className="form-group">
              <label htmlFor={tabNameId}>Cat. {i + 1} Tab Name</label>
              <div className="input-container">
                <input value={tabNameText} type="text" onChange={this.onCategoryTabNameChange.bind(this, categoryId)} className="form-control" id={tabNameId} />
              </div>
            </div>
            <div className="form-group">
              <label htmlFor={bodyId}>Cat. {i + 1} Prompt</label>
              <div className="input-container">
                <textarea value={bodyText} onChange={this.onCategoryBodyChange.bind(this, categoryId)} className="form-control" id={bodyId} name={bodyId}  />
              </div>
            </div>
            <hr/>
          </div>
        );
      }
      return categoryNodes;
    }
  });
})();

