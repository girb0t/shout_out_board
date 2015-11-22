(function() {
  "use strict";

  BoardStage = React.createClass({
    propTypes: {
      title: React.PropTypes.string.isRequired,
      boardKey: React.PropTypes.string.isRequired,
      categories: React.PropTypes.instanceOf(Immutable.List).isRequired,
    },

    render: function(){
      // debugger
      return(
        <div>
        </div>
      );
    }
  });
})();
