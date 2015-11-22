var BoardStage = BoardStage || {};

(function() {
  "use strict";
  BoardStage.BoardStage= React.createClass({
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
      var categoryNodes = this._categoryNodes();
      return(
        <div id="board-stage-wrapper">
          <div className="text-center"><h1>{this.state.title}</h1></div>
          <div className="text-center"><h2>{this.state.boardKey}</h2></div>
          <div id="board-stage">
            <div className="row">
              {categoryNodes}
            </div>
          </div>
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

    _categoryNodes: function() {
      if(this.state.categories.size){
        var result;
        var colSize = 12 / this.state.categories.size;
        var className = "category-col col-md-" + colSize;
        result = this.state.categories.map(function(cat, index){
          return (
            <div className={className} key={index}>
              <BoardStage.Category
                title={cat.get('title')}
                posts={cat.get('posts')}
              />
            </div>
          );
        });
        return result;
      }
    },
  });
})();
