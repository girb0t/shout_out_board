(function() {
  "use strict";

  BoardStage = React.createClass({
    propTypes: {
      boardKey: React.PropTypes.string.isRequired,
    },

    getInitialState: function() {
      return {
        boardKey: this.props.boardKey,
        title: "",
        categories: Immutable.List(),
        isActive: false,
      };
    },

    componentDidMount: function() {
      this._getBoardData();
    },

    render: function() {
      return(
        <div>
          <h1>title: {this.state.title}</h1>
          <h1>key: {this.state.boardKey}</h1>
          <h1>isActive: {this.state.isActive.toString()}</h1>
          <h1>Category Count: {this.state.categories.size}</h1>
        </div>
      );
    },

    _getBoardData: function() {
      var that = this;
      $.ajax({
        dataType: "json",
        url: this.state.boardKey + ".json",
        success: function(result) {
          result = Immutable.fromJS(result);
          that.setState({
            title: result.get('title'),
            categories: result.get('categories'),
            isActive: result.get('active'),
          });
        }
      });
    },
  });
})();
