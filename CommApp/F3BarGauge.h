#import <UIKit/UIKit.h>


//------------------------------------------------------------------------
//------------------------------------------------------------------------
//------------------|  F3BarGauge class definition  |---------------------
//------------------------------------------------------------------------
//------------------------------------------------------------------------
@interface F3BarGauge : UIView
{
@private
    BOOL        m_fHoldPeak,            // YES = hold peak value enabled
    m_fLitEffect,           // YES = draw segments with gradient "lit-up" effect
    m_fReverseDirection;    // YES = top-to-bottom or right-to-left
    float       m_flValue,              // Current value being displayed
    m_flPeakValue,          // Peak value seen since reset
    m_flMaxLimit,           // Maximum displayable value
    m_flMinLimit,           // Minimum displayable value
    m_flWarnThreshold,      // Warning threshold (segment color specified by m_clrWarning)
    m_flDangerThreshold;    // Danger threshold (segment color specified by m_clrDanger)
    int         m_iNumBars;             // Number of segments
    UIColor     *m_clrOuterBorder,      // Color of outer border
    *m_clrInnerBorder,      // Color of inner border
    *m_clrBackground,       // Background color of gauge
    *m_clrNormal,           // Normal segment color
    *m_clrWarning,          // Warning segment color
    *m_clrDanger;           // Danger segment color
}

@property (readwrite, nonatomic)  float     value;
@property (readwrite, nonatomic)  float     warnThreshold;
@property (readwrite, nonatomic)  float     dangerThreshold;
@property (readwrite, nonatomic)  float     maxLimit;
@property (readwrite, nonatomic)  float     minLimit;
@property (readwrite, nonatomic)  int       numBars;
@property (readonly, nonatomic)   float     peakValue;
@property (readwrite, nonatomic)  BOOL      holdPeak;
@property (readwrite, nonatomic)  BOOL      litEffect;
@property (readwrite, nonatomic)  BOOL      reverse;
@property (readwrite, retain)     UIColor   *outerBorderColor;
@property (readwrite, retain)     UIColor   *innerBorderColor;
@property (readwrite, retain)     UIColor   *backgroundColor;
@property (readwrite, retain)     UIColor   *normalBarColor;
@property (readwrite, retain)     UIColor   *warningBarColor;
@property (readwrite, retain)     UIColor   *dangerBarColor;

-(void) resetPeak;



@end
