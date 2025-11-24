pragma Singleton
import QtQuick

QtObject {
    /*-------------------------------------------------------*/
    /*                         BAR                           */
    /*-------------------------------------------------------*/
    property int barHeight: 35
    property int barWidth:1000 
    property int barY:30
    property int barAnimation:150
    /*-------------------------------------------------------*/
    /*                     CLOCK DRAWER                      */
    /*-------------------------------------------------------*/
    property int clockDrawerWidth: 100
    property bool clockDrawerLeft:false

    property int clockWidth:   40
    property int clockHeight:  21
    property int clockTextSize:10

    property int dateWidth:   40
    property int dateHeight:  21 
    property int dateTextSize:10 
    /*-------------------------------------------------------*/
    /*                         ALL                           */
    /*-------------------------------------------------------*/
    property int radiusAll: 20
    property int textSize:10

    property color backgroundColor: "#80050512" 
    property color background2Color:"#803a6bce"
    property color background3Color:"#313244"

    property color textColor:       "#fface6f3"
    property color textColorDim:    "#aaace6f3" 
    /*-------------------------------------------------------*/
    /*                        FRAME                          */
    /*-------------------------------------------------------*/
    property int frameThick: 10
    property int frameRadius:30
    
    property color frameColor:"#dd100512"
    
}
