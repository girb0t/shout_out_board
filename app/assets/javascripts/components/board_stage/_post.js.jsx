var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.Post = React.createClass({
    propTyypes: {
      key: React.PropTypes.integer,
      body: React.PropTypes.string.isRequired,
    },

    getDefaultProps: function() {
      return({
        body: "",
      });
    },

    render: function() {
      return(
        <div>
          <p className="post" key={this.props.key}>{this.props.body}</p>
        </div>
      );
    }
  });
})();
