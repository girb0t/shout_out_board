(function() {
  "use strict";

  BoardStageWrapper = React.createClass({
    propTypes: {
      boardStageData: React.PropTypes.instanceOf(Immutable.Map).isRequired,
    },

    render: function() {
      return(
        <div>
          <BoardStage
            title={this.props.boardStageData.get('title')}
            boardKey={this.props.boardStageData.get('key')}
            categories={this.props.boardStageData.get('categories')}
          />
        </div>
      );
    },
  });
})();
