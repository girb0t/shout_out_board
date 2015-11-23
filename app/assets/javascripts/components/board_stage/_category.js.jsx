var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.Category = React.createClass({
    propTypes: {
      colSizeClass: React.PropTypes.string.isRequired,
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
      var className = "category-col " + this.props.colSizeClass;
      return(
        <div className={className} key={this.props.key}>
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
