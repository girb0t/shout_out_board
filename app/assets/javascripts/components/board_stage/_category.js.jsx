var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.Category = React.createClass({
    propTypes: {
      title: React.PropTypes.string.isRequired,
      posts: React.PropTypes.instanceOf(Immutable.List).isRequired,
    },

    getDefaultProps: function() {
      return({
        title: "",
        posts: Immutable.List(),
      });
    },

    render: function() {
      return(
        <div>
          <h2 className="text-center">{this.props.title}</h2>
        </div>
      );
    }
  });
})();
