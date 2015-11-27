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
      this._initiateLongPolling();
    },

    componentDidUpdate: function() {
      this._adjustDimensions();
    },

    render: function() {
      var categoryHeaderNodes = this._categoryHeaderNodes();
      var categoryNodes = this._categoryNodes();
      return(
        <div id="board-stage-wrapper">
          <div className="text-center"><h1>{this.state.title}</h1></div>
          <div className="text-center"><h2>key: {this.state.boardKey}</h2></div>
          <div id="board-stage">
            <div className="row" id="category-header-row">
              {categoryHeaderNodes}
            </div>
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
        url: "/boards/" + that.state.boardKey + ".json",
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

    _categoryHeaderNodes: function() {
      if(this.state.categories.size) {
        var that = this;
        var result;
        var className = "category-header " + this._categoryColSizeClass();
        result = this.state.categories.map(function(cat, index){
          return (
            <div className={className} key={index}>
              <p className="text-center">{cat.get('title')}</p>
            </div>
          );
        });
        return result;
      }
    },

    _categoryNodes: function() {
      if(this.state.categories.size) {
        var that = this;
        var result;
        result = this.state.categories.map(function(cat, index){
          return (
            <BoardStage.Category
              key={index}
              colSizeClass={that._categoryColSizeClass()}
              title={cat.get('title')}
              posts={cat.get('posts')}
            />
          );
        });
        return result;
      }
    },

    _categoryColSizeClass: function() {
      var colSize = 12 / this.state.categories.size;
      var className = "col-xs-" + colSize;
          className += " col-sm-" + colSize;
          className += " col-md-" + colSize;
          className += " col-lg-" + colSize;
      return className;
    },

    _adjustDimensions: function() {
      //make category header height uniform
      var headerHeight = $("#category-header-row").css('height');
      if(headerHeight && headerHeight!=="0px") {
        $(".category-header").css('height', headerHeight);
      }
    },

    _initiateLongPolling: function() {
      var that = this;
      (function poll() {
        setTimeout(function() {
          $.ajax({
            dataType: "json",
            url: "/boards/" + that.state.boardKey + ".json",
            success: function(result) {
              result = Immutable.fromJS(result);
              that.setState({
                title: result.get('title'),
                categories: result.get('categories'),
                isActive: result.get('active'),
              });
              poll();
            }
          });
        }, 3000);
      })();
    },
  });
})();
