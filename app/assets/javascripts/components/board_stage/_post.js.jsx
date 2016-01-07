var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.Post = React.createClass({
    propTyypes: {
      key: React.PropTypes.integer,
      body: React.PropTypes.string.isRequired,
      style: React.PropTypes.shape({
        color: React.PropTypes.string,
        backgroundColor: React.PropTypes.string,
      }),
    },

    getDefaultProps: function() {
      return({
        body: "",
        style: {
          color: "#000000", //TODO store these defaults in one place
          backgroundColor: "#bfff80"
        }
      });
    },

    render: function() {
      return(
        <div>
          <p className="post" key={this.props.key} style={this.props.style}>{this.props.body}</p>
        </div>
      );
    }
  });
})();
