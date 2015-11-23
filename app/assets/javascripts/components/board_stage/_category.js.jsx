var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.Category = React.createClass({
    propTypes: {
      className: React.PropTypes.string.isRequired,
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
      var postNodes = this._postNodes();
      return(
        <div className={this.props.className} key={this.props.key}>
          <h2 className="text-center">{this.props.title}</h2>
          {postNodes}
        </div>
      );
    },

    _postNodes: function() {
      var result = this.props.posts.map(function(post, index) {
        return(
          <BoardStage.Post
            key={index}
            body={post.get('body')}
          />
        );
      });
      return result;
    },
  });
})();
