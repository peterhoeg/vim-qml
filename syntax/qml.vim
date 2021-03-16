" Vim syntax file
" Language:     QML
" Maintainer:   Peter Hoeg <peter@hoeg.com>
" Updaters:     Refer to CONTRIBUTORS.md
" URL:          https://github.com/peterhoeg/vim-qml
" Changes:      `git log` is your friend
" Last Change:  2017-11-11
"
" This file is bassed on the original work done by Warwick Allison
" <warwick.allison@nokia.com> whose did about 99% of the work here.

" Based on javascript syntax (as is QML)

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'qml'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("qml_fold")
  unlet qml_fold
endif

syn case match

syn cluster qmlExpr         contains=qmlStringD,qmlStringS,qmlStringT,SqmlCharacter,qmlNumber,qmlBoolean,qmlBasicType,qmlJsType,qmlObjectType,qmlAliasType,qmlNull,qmlGlobal,qmlFunction,qmlArrowFunction
syn keyword qmlCommentTodo  TODO FIXME XXX TBD contained
syn match   qmlLineComment  "\/\/.*" contains=@Spell,qmlCommentTodo
syn match   qmlCommentSkip  "^[ \t]*\*\($\|[ \t]\+\)"
syn region  qmlComment      start="/\*"  end="\*/" contains=@Spell,qmlCommentTodo fold
syn match   qmlSpecial      "\\\d\d\d\|\\."
syn region  qmlStringD      start=+"+  skip=+\\\\\|\\"\|\\$+  end=+"+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell
syn region  qmlStringS      start=+'+  skip=+\\\\\|\\'\|\\$+  end=+'+  keepend  contains=qmlSpecial,@htmlPreproc,@Spell
syn region  qmlStringT      start=+`+  skip=+\\\\\|\\`\|\\$+  end=+`+  keepend  contains=qmlTemplateExpr,qmlSpecial,@htmlPreproc,@Spell

syntax region  qmlTemplateExpr contained  matchgroup=qmlBraces start=+${+ end=+}+  keepend  contains=@qmlExpr

syn match  qmlCharacter           "'\\.'"
syn match  qmlNumber              "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region qmlRegexpString        start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn match  qmlObjectDefinition    "[A-Z][_A-Za-z0-9]*\(\s*{\|\s\+on\s\+\)\@=" nextgroup=qmlPropModifierOn
syn match  qmlPropModifierOn      "\s\+on\s\+" contained nextgroup=qmlPropModifierTarget
syn match  qmlPropModifierTarget  "[_a-z][_A-Za-z.0-9]*\s*\({\)\@=" contained
syn region qmlTernaryColon        start="?" end=":" contains=@qmlExpr,qmlBraces,qmlParens
syn match  qmlPropertyName        "\<[_a-z][_A-Za-z.0-9]*\s*:"
syn match  qmlGroupProperty       "[_a-z][_A-Za-z0-9]*\s*\({\)\@="

syn keyword qmlConditional  if else switch
syn keyword qmlRepeat       while for do in
syn keyword qmlBranch       break continue
syn keyword qmlOperator     new delete instanceof typeof
syn keyword qmlAliasType    alias
syn keyword qmlStatement    return with
syn keyword qmlBoolean      true false
syn keyword qmlNull         null undefined
syn keyword qmlIdentifier   arguments this var let const
syn keyword qmlLabel        case default
syn keyword qmlException    try catch finally throw
syn keyword qmlMessage      alert confirm prompt status
syn keyword qmlGlobal       self
syn keyword qmlDeclaration  property signal component readonly required
syn keyword qmlReserved     abstract boolean byte char class debugger enum export extends final float goto implements import interface long native package pragma private protected public short static super synchronized throws transient volatile

" List extracted in alphabatical order from: https://doc.qt.io/qt-5/qmlbasictypes.html
" Qt v5.15.1

" Basic Types {{{

let basicTypes = [ "bool",
                 \ "color",
                 \ "coordinate",
                 \ "date",
                 \ "double",
                 \ "enumeration",
                 \ "font",
                 \ "geocircle",
                 \ "geopath",
                 \ "geopolygon",
                 \ "georectangle",
                 \ "geoshape",
                 \ "int",
                 \ "list",
                 \ "matrix4x4",
                 \ "palette",
                 \ "point",
                 \ "quaternion",
                 \ "real",
                 \ "rect",
                 \ "size",
                 \ "string",
                 \ "url",
                 \ "var",
                 \ "variant",
                 \ "vector2d",
                 \ "vector3d",
                 \ "vector4d" ]

exec "syntax match qmlBasicType \"\\.\\@<!\\<\\(".join(basicTypes, "\\|")."\\)\\>[:.]\\@!\""

" }}}

" List extracted in alphabatical order from: https://doc.qt.io/qt-5/qtqml-javascript-functionlist.html
" Qt v5.15.1

" JavaScript Types {{{

syn keyword qmlJsType Array
syn keyword qmlJsType ArrayBuffer
syn keyword qmlJsType Boolean
syn keyword qmlJsType DataView
syn keyword qmlJsType Date
syn keyword qmlJsType Error
syn keyword qmlJsType EvalError
syn keyword qmlJsType Function
syn keyword qmlJsType Map
syn keyword qmlJsType Number
syn keyword qmlJsType Object
syn keyword qmlJsType Promise
syn keyword qmlJsType RangeError
syn keyword qmlJsType ReferenceError
syn keyword qmlJsType RegExp
syn keyword qmlJsType Set
syn keyword qmlJsType SharedArrayBuffer
syn keyword qmlJsType String
syn keyword qmlJsType Symbol
syn keyword qmlJsType SyntaxError
syn keyword qmlJsType TypeError
syn keyword qmlJsType URIError
syn keyword qmlJsType WeakMap
syn keyword qmlJsType WeakSet

" }}}

" List extracted in alphabatical order from: https://doc.qt.io/qt-5/qmltypes.html
" Property modifier types from: https://doc.qt.io/qt-5/qtqml-cppintegration-definetypes.html#property-modifier-types
" Qt v5.15.1
" NOTE: The basic and JS types previously listed are excluded from this list.

" Built-in Components {{{

syntax keyword qmlObjectType Abstract3DSeries
syntax keyword qmlObjectType AbstractActionInput
syntax keyword qmlObjectType AbstractAnimation
syntax keyword qmlObjectType AbstractAxis
syntax keyword qmlObjectType AbstractAxis3D
syntax keyword qmlObjectType AbstractAxisInput
syntax keyword qmlObjectType AbstractBarSeries
syntax keyword qmlObjectType AbstractButton
syntax keyword qmlObjectType AbstractClipAnimator
syntax keyword qmlObjectType AbstractClipBlendNode
syntax keyword qmlObjectType AbstractDataProxy
syntax keyword qmlObjectType AbstractGraph3D
syntax keyword qmlObjectType AbstractInputHandler3D
syntax keyword qmlObjectType AbstractPhysicalDevice
syntax keyword qmlObjectType AbstractRayCaster
syntax keyword qmlObjectType AbstractSeries
syntax keyword qmlObjectType AbstractSkeleton
syntax keyword qmlObjectType AbstractTexture
syntax keyword qmlObjectType AbstractTextureImage
syntax keyword qmlObjectType Accelerometer
syntax keyword qmlObjectType AccelerometerReading
syntax keyword qmlObjectType Accessible
syntax keyword qmlObjectType Action
syntax keyword qmlObjectType ActionGroup
syntax keyword qmlObjectType ActionInput
syntax keyword qmlObjectType AdditiveClipBlend
syntax keyword qmlObjectType AdditiveColorGradient
syntax keyword qmlObjectType Address
syntax keyword qmlObjectType Affector
syntax keyword qmlObjectType Age
syntax keyword qmlObjectType AlphaCoverage
syntax keyword qmlObjectType AlphaTest
syntax keyword qmlObjectType Altimeter
syntax keyword qmlObjectType AltimeterReading
syntax keyword qmlObjectType AluminumAnodizedEmissiveMaterial
syntax keyword qmlObjectType AluminumAnodizedMaterial
syntax keyword qmlObjectType AluminumBrushedMaterial
syntax keyword qmlObjectType AluminumEmissiveMaterial
syntax keyword qmlObjectType AluminumMaterial
syntax keyword qmlObjectType AmbientLightReading
syntax keyword qmlObjectType AmbientLightSensor
syntax keyword qmlObjectType AmbientTemperatureReading
syntax keyword qmlObjectType AmbientTemperatureSensor
syntax keyword qmlObjectType AnalogAxisInput
syntax keyword qmlObjectType AnchorAnimation
syntax keyword qmlObjectType AnchorChanges
syntax keyword qmlObjectType AngleDirection
syntax keyword qmlObjectType AnimatedImage
syntax keyword qmlObjectType AnimatedSprite
syntax keyword qmlObjectType Animation
syntax keyword qmlObjectType AnimationController
syntax keyword qmlObjectType AnimationGroup
syntax keyword qmlObjectType Animator
syntax keyword qmlObjectType ApplicationWindow
syntax keyword qmlObjectType ApplicationWindowStyle
syntax keyword qmlObjectType AreaLight
syntax keyword qmlObjectType AreaSeries
syntax keyword qmlObjectType Armature
syntax keyword qmlObjectType AttenuationModelInverse
syntax keyword qmlObjectType AttenuationModelLinear
syntax keyword qmlObjectType Attractor
syntax keyword qmlObjectType Attribute
syntax keyword qmlObjectType Audio
syntax keyword qmlObjectType AudioCategory
syntax keyword qmlObjectType AudioEngine
syntax keyword qmlObjectType AudioListener
syntax keyword qmlObjectType AudioSample
syntax keyword qmlObjectType AuthenticationDialogRequest
syntax keyword qmlObjectType Axis
syntax keyword qmlObjectType AxisAccumulator
syntax keyword qmlObjectType AxisHelper
syntax keyword qmlObjectType AxisSetting

syntax keyword qmlObjectType BackspaceKey
syntax keyword qmlObjectType Bar3DSeries
syntax keyword qmlObjectType BarCategoryAxis
syntax keyword qmlObjectType BarDataProxy
syntax keyword qmlObjectType Bars3D
syntax keyword qmlObjectType BarSeries
syntax keyword qmlObjectType BarSet
syntax keyword qmlObjectType BaseKey
syntax keyword qmlObjectType BasicTableView
syntax keyword qmlObjectType Behavior nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType Binding
syntax keyword qmlObjectType Blend
syntax keyword qmlObjectType BlendedClipAnimator
syntax keyword qmlObjectType BlendEquation
syntax keyword qmlObjectType BlendEquationArguments
syntax keyword qmlObjectType Blending
syntax keyword qmlObjectType BlitFramebuffer
syntax keyword qmlObjectType BluetoothDiscoveryModel
syntax keyword qmlObjectType BluetoothService
syntax keyword qmlObjectType BluetoothSocket
syntax keyword qmlObjectType Blur
syntax keyword qmlObjectType BorderImage
syntax keyword qmlObjectType BorderImageMesh
syntax keyword qmlObjectType BoundaryRule
syntax keyword qmlObjectType Bounds
syntax keyword qmlObjectType BoxPlotSeries
syntax keyword qmlObjectType BoxSet
syntax keyword qmlObjectType BrightnessContrast
syntax keyword qmlObjectType BrushStrokes
syntax keyword qmlObjectType Buffer
syntax keyword qmlObjectType BufferBlit
syntax keyword qmlObjectType BufferCapture
syntax keyword qmlObjectType BufferInput
syntax keyword qmlObjectType BusyIndicator
syntax keyword qmlObjectType BusyIndicatorStyle
syntax keyword qmlObjectType Button
syntax keyword qmlObjectType ButtonAxisInput
syntax keyword qmlObjectType ButtonGroup
syntax keyword qmlObjectType ButtonStyle

syntax keyword qmlObjectType Calendar
syntax keyword qmlObjectType CalendarModel
syntax keyword qmlObjectType CalendarStyle
syntax keyword qmlObjectType Camera
syntax keyword qmlObjectType Camera3D
syntax keyword qmlObjectType CameraCapabilities
syntax keyword qmlObjectType CameraCapture
syntax keyword qmlObjectType CameraExposure
syntax keyword qmlObjectType CameraFlash
syntax keyword qmlObjectType CameraFocus
syntax keyword qmlObjectType CameraImageProcessing
syntax keyword qmlObjectType CameraLens
syntax keyword qmlObjectType CameraRecorder
syntax keyword qmlObjectType CameraSelector
syntax keyword qmlObjectType CandlestickSeries
syntax keyword qmlObjectType CandlestickSet
syntax keyword qmlObjectType Canvas
syntax keyword qmlObjectType CanvasGradient
syntax keyword qmlObjectType CanvasImageData
syntax keyword qmlObjectType CanvasPixelArray
syntax keyword qmlObjectType Category
syntax keyword qmlObjectType CategoryAxis
syntax keyword qmlObjectType CategoryAxis3D
syntax keyword qmlObjectType CategoryModel
syntax keyword qmlObjectType CategoryRange
syntax keyword qmlObjectType ChangeLanguageKey
syntax keyword qmlObjectType ChartView
syntax keyword qmlObjectType CheckBox
syntax keyword qmlObjectType CheckBoxStyle
syntax keyword qmlObjectType CheckDelegate
syntax keyword qmlObjectType ChromaticAberration
syntax keyword qmlObjectType CircularGauge
syntax keyword qmlObjectType CircularGaugeStyle
syntax keyword qmlObjectType ClearBuffers
syntax keyword qmlObjectType ClipAnimator
syntax keyword qmlObjectType ClipBlendValue
syntax keyword qmlObjectType ClipPlane
syntax keyword qmlObjectType CloseEvent
syntax keyword qmlObjectType ColorAnimation nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType ColorDialog
syntax keyword qmlObjectType ColorDialogRequest
syntax keyword qmlObjectType ColorGradient
syntax keyword qmlObjectType ColorGradientStop
syntax keyword qmlObjectType Colorize
syntax keyword qmlObjectType ColorMask
syntax keyword qmlObjectType ColorMaster
syntax keyword qmlObjectType ColorOverlay
syntax keyword qmlObjectType Column
syntax keyword qmlObjectType ColumnLayout
syntax keyword qmlObjectType ComboBox
syntax keyword qmlObjectType ComboBoxStyle
syntax keyword qmlObjectType Command
syntax keyword qmlObjectType Compass
syntax keyword qmlObjectType CompassReading
syntax keyword qmlObjectType Component
syntax keyword qmlObjectType Component3D
syntax keyword qmlObjectType ComputeCommand
syntax keyword qmlObjectType ConeGeometry
syntax keyword qmlObjectType ConeMesh
syntax keyword qmlObjectType ConicalGradient
syntax keyword qmlObjectType Connections
syntax keyword qmlObjectType ContactDetail
syntax keyword qmlObjectType ContactDetails
syntax keyword qmlObjectType Container
syntax keyword qmlObjectType Context2D
syntax keyword qmlObjectType ContextMenuRequest
syntax keyword qmlObjectType Control
syntax keyword qmlObjectType CoordinateAnimation
syntax keyword qmlObjectType CopperMaterial
syntax keyword qmlObjectType CuboidGeometry
syntax keyword qmlObjectType CuboidMesh
syntax keyword qmlObjectType CullFace
syntax keyword qmlObjectType CullMode
syntax keyword qmlObjectType CumulativeDirection
syntax keyword qmlObjectType Custom3DItem
syntax keyword qmlObjectType Custom3DLabel
syntax keyword qmlObjectType Custom3DVolume
syntax keyword qmlObjectType CustomCamera
syntax keyword qmlObjectType CustomMaterial
syntax keyword qmlObjectType CustomParticle
syntax keyword qmlObjectType CylinderGeometry
syntax keyword qmlObjectType CylinderMesh

syntax keyword qmlObjectType DateTimeAxis
syntax keyword qmlObjectType DayOfWeekRow
syntax keyword qmlObjectType DebugView
syntax keyword qmlObjectType DefaultMaterial
syntax keyword qmlObjectType DelayButton
syntax keyword qmlObjectType DelayButtonStyle
syntax keyword qmlObjectType DelegateChoice
syntax keyword qmlObjectType DelegateChooser
syntax keyword qmlObjectType DelegateModel
syntax keyword qmlObjectType DelegateModelGroup
syntax keyword qmlObjectType DepthInput
syntax keyword qmlObjectType DepthOfFieldHQBlur
syntax keyword qmlObjectType DepthRange
syntax keyword qmlObjectType DepthTest
syntax keyword qmlObjectType Desaturate
syntax keyword qmlObjectType Dial
syntax keyword qmlObjectType Dialog
syntax keyword qmlObjectType DialogButtonBox
syntax keyword qmlObjectType DialStyle
syntax keyword qmlObjectType DiffuseMapMaterial
syntax keyword qmlObjectType DiffuseSpecularMapMaterial
syntax keyword qmlObjectType DiffuseSpecularMaterial
syntax keyword qmlObjectType Direction
syntax keyword qmlObjectType DirectionalBlur
syntax keyword qmlObjectType DirectionalLight
syntax keyword qmlObjectType DispatchCompute
syntax keyword qmlObjectType Displace
syntax keyword qmlObjectType DistanceReading
syntax keyword qmlObjectType DistanceSensor
syntax keyword qmlObjectType DistortionRipple
syntax keyword qmlObjectType DistortionSphere
syntax keyword qmlObjectType DistortionSpiral
syntax keyword qmlObjectType Dithering
syntax keyword qmlObjectType DoubleValidator
syntax keyword qmlObjectType Drag
syntax keyword qmlObjectType DragEvent
syntax keyword qmlObjectType DragHandler
syntax keyword qmlObjectType Drawer
syntax keyword qmlObjectType DropArea
syntax keyword qmlObjectType DropShadow
syntax keyword qmlObjectType DwmFeatures
syntax keyword qmlObjectType DynamicParameter

syntax keyword qmlObjectType EdgeDetect
syntax keyword qmlObjectType EditorialModel
syntax keyword qmlObjectType Effect
syntax keyword qmlObjectType EllipseShape
syntax keyword qmlObjectType Emboss
syntax keyword qmlObjectType Emitter
syntax keyword qmlObjectType EnterKey
syntax keyword qmlObjectType EnterKeyAction
syntax keyword qmlObjectType Entity
syntax keyword qmlObjectType EntityLoader
syntax keyword qmlObjectType EnvironmentLight
syntax keyword qmlObjectType EventConnection
syntax keyword qmlObjectType EventPoint
syntax keyword qmlObjectType EventTouchPoint
syntax keyword qmlObjectType ExclusiveGroup
syntax keyword qmlObjectType ExtendedAttributes
syntax keyword qmlObjectType ExtrudedTextGeometry
syntax keyword qmlObjectType ExtrudedTextMesh

syntax keyword qmlObjectType FastBlur
syntax keyword qmlObjectType FileDialog
syntax keyword qmlObjectType FileDialogRequest
syntax keyword qmlObjectType FillerKey
syntax keyword qmlObjectType FilterKey
syntax keyword qmlObjectType FinalState
syntax keyword qmlObjectType FindTextResult
syntax keyword qmlObjectType FirstPersonCameraController
syntax keyword qmlObjectType Flickable
syntax keyword qmlObjectType Flip
syntax keyword qmlObjectType Flipable
syntax keyword qmlObjectType Flow
syntax keyword qmlObjectType FocusScope
syntax keyword qmlObjectType FolderDialog
syntax keyword qmlObjectType FolderListModel
syntax keyword qmlObjectType FontDialog
syntax keyword qmlObjectType FontLoader
syntax keyword qmlObjectType FontMetrics
syntax keyword qmlObjectType FormValidationMessageRequest
syntax keyword qmlObjectType ForwardRenderer
syntax keyword qmlObjectType Frame
syntax keyword qmlObjectType FrameAction
syntax keyword qmlObjectType FrameGraphNode
syntax keyword qmlObjectType Friction
syntax keyword qmlObjectType FrontFace
syntax keyword qmlObjectType FrostedGlassMaterial
syntax keyword qmlObjectType FrostedGlassSinglePassMaterial
syntax keyword qmlObjectType FrustumCamera
syntax keyword qmlObjectType FrustumCulling
syntax keyword qmlObjectType FullScreenRequest
syntax keyword qmlObjectType Fxaa

syntax keyword qmlObjectType Gamepad
syntax keyword qmlObjectType GamepadManager
syntax keyword qmlObjectType GammaAdjust
syntax keyword qmlObjectType Gauge
syntax keyword qmlObjectType GaugeStyle
syntax keyword qmlObjectType GaussianBlur
syntax keyword qmlObjectType GeocodeModel
syntax keyword qmlObjectType Geometry
syntax keyword qmlObjectType GeometryRenderer
syntax keyword qmlObjectType GestureEvent
syntax keyword qmlObjectType GlassMaterial
syntax keyword qmlObjectType GlassRefractiveMaterial
syntax keyword qmlObjectType Glow
syntax keyword qmlObjectType GoochMaterial
syntax keyword qmlObjectType Gradient
syntax keyword qmlObjectType GradientStop
syntax keyword qmlObjectType GraphicsApiFilter
syntax keyword qmlObjectType GraphicsInfo
syntax keyword qmlObjectType Gravity
syntax keyword qmlObjectType Grid
syntax keyword qmlObjectType GridGeometry
syntax keyword qmlObjectType GridLayout
syntax keyword qmlObjectType GridMesh
syntax keyword qmlObjectType GridView
syntax keyword qmlObjectType GroupBox
syntax keyword qmlObjectType GroupGoal
syntax keyword qmlObjectType Gyroscope
syntax keyword qmlObjectType GyroscopeReading

syntax keyword qmlObjectType HandlerPoint
syntax keyword qmlObjectType HandwritingInputPanel
syntax keyword qmlObjectType HandwritingModeKey
syntax keyword qmlObjectType HBarModelMapper
syntax keyword qmlObjectType HBoxPlotModelMapper
syntax keyword qmlObjectType HCandlestickModelMapper
syntax keyword qmlObjectType HDRBloomTonemap
syntax keyword qmlObjectType HeightMapSurfaceDataProxy
syntax keyword qmlObjectType HideKeyboardKey
syntax keyword qmlObjectType HistoryState
syntax keyword qmlObjectType HolsterReading
syntax keyword qmlObjectType HolsterSensor
syntax keyword qmlObjectType HorizontalBarSeries
syntax keyword qmlObjectType HorizontalHeaderView
syntax keyword qmlObjectType HorizontalPercentBarSeries
syntax keyword qmlObjectType HorizontalStackedBarSeries
syntax keyword qmlObjectType Host
syntax keyword qmlObjectType HoverHandler
syntax keyword qmlObjectType HPieModelMapper
syntax keyword qmlObjectType HueSaturation
syntax keyword qmlObjectType HumidityReading
syntax keyword qmlObjectType HumiditySensor
syntax keyword qmlObjectType HXYModelMapper

syntax keyword qmlObjectType Icon
syntax keyword qmlObjectType IdleInhibitManagerV1
syntax keyword qmlObjectType Image
syntax keyword qmlObjectType ImageModel
syntax keyword qmlObjectType ImageParticle
syntax keyword qmlObjectType InnerShadow
syntax keyword qmlObjectType InputChord
syntax keyword qmlObjectType InputContext
syntax keyword qmlObjectType InputEngine
syntax keyword qmlObjectType InputHandler3D
syntax keyword qmlObjectType InputMethod
syntax keyword qmlObjectType InputModeKey
syntax keyword qmlObjectType InputPanel
syntax keyword qmlObjectType InputSequence
syntax keyword qmlObjectType InputSettings
syntax keyword qmlObjectType Instantiator
syntax keyword qmlObjectType IntValidator
syntax keyword qmlObjectType InvokedServices
syntax keyword qmlObjectType IRProximityReading
syntax keyword qmlObjectType IRProximitySensor
syntax keyword qmlObjectType Item
syntax keyword qmlObjectType ItemDelegate
syntax keyword qmlObjectType ItemGrabResult
syntax keyword qmlObjectType ItemModelBarDataProxy
syntax keyword qmlObjectType ItemModelScatterDataProxy
syntax keyword qmlObjectType ItemModelSurfaceDataProxy
syntax keyword qmlObjectType ItemParticle
syntax keyword qmlObjectType ItemSelectionModel
syntax keyword qmlObjectType IviApplication
syntax keyword qmlObjectType IviSurface

syntax keyword qmlObjectType JavaScriptDialogRequest
syntax keyword qmlObjectType Joint
syntax keyword qmlObjectType JumpList
syntax keyword qmlObjectType JumpListCategory
syntax keyword qmlObjectType JumpListDestination
syntax keyword qmlObjectType JumpListLink
syntax keyword qmlObjectType JumpListSeparator

syntax keyword qmlObjectType Key
syntax keyword qmlObjectType KeyboardColumn
syntax keyword qmlObjectType KeyboardDevice
syntax keyword qmlObjectType KeyboardHandler
syntax keyword qmlObjectType KeyboardLayout
syntax keyword qmlObjectType KeyboardLayoutLoader
syntax keyword qmlObjectType KeyboardRow
syntax keyword qmlObjectType KeyboardStyle
syntax keyword qmlObjectType KeyEvent
syntax keyword qmlObjectType Keyframe
syntax keyword qmlObjectType KeyframeAnimation
syntax keyword qmlObjectType KeyframeGroup
syntax keyword qmlObjectType KeyIcon
syntax keyword qmlObjectType KeyNavigation
syntax keyword qmlObjectType KeyPanel
syntax keyword qmlObjectType Keys

syntax keyword qmlObjectType Label
syntax keyword qmlObjectType Layer
syntax keyword qmlObjectType LayerFilter
syntax keyword qmlObjectType Layout
syntax keyword qmlObjectType LayoutMirroring
syntax keyword qmlObjectType Legend
syntax keyword qmlObjectType LerpClipBlend
syntax keyword qmlObjectType LevelAdjust
syntax keyword qmlObjectType LevelOfDetail
syntax keyword qmlObjectType LevelOfDetailBoundingSphere
syntax keyword qmlObjectType LevelOfDetailLoader
syntax keyword qmlObjectType LevelOfDetailSwitch
syntax keyword qmlObjectType LidReading
syntax keyword qmlObjectType LidSensor
syntax keyword qmlObjectType Light
syntax keyword qmlObjectType Light3D
syntax keyword qmlObjectType LightReading
syntax keyword qmlObjectType LightSensor
syntax keyword qmlObjectType LinearGradient
syntax keyword qmlObjectType LineSeries
syntax keyword qmlObjectType LineShape
syntax keyword qmlObjectType LineWidth
syntax keyword qmlObjectType ListElement
syntax keyword qmlObjectType ListModel
syntax keyword qmlObjectType ListView
syntax keyword qmlObjectType Loader
syntax keyword qmlObjectType Loader3D
syntax keyword qmlObjectType Locale
syntax keyword qmlObjectType Location
syntax keyword qmlObjectType LoggingCategory
syntax keyword qmlObjectType LogicalDevice
syntax keyword qmlObjectType LogValueAxis
syntax keyword qmlObjectType LogValueAxis3DFormatter
syntax keyword qmlObjectType LottieAnimation

syntax keyword qmlObjectType Magnetometer
syntax keyword qmlObjectType MagnetometerReading
syntax keyword qmlObjectType MapCircle
syntax keyword qmlObjectType MapCircleObject
syntax keyword qmlObjectType MapCopyrightNotice
syntax keyword qmlObjectType MapGestureArea
syntax keyword qmlObjectType MapIconObject
syntax keyword qmlObjectType MapItemGroup
syntax keyword qmlObjectType MapItemView
syntax keyword qmlObjectType MapObjectView
syntax keyword qmlObjectType MapParameter
syntax keyword qmlObjectType MapPinchEvent
syntax keyword qmlObjectType MapPolygon
syntax keyword qmlObjectType MapPolygonObject
syntax keyword qmlObjectType MapPolyline
syntax keyword qmlObjectType MapPolylineObject
syntax keyword qmlObjectType MapQuickItem
syntax keyword qmlObjectType MapRectangle
syntax keyword qmlObjectType MapRoute
syntax keyword qmlObjectType MapRouteObject
syntax keyword qmlObjectType MapType
syntax keyword qmlObjectType Margins
syntax keyword qmlObjectType MaskedBlur
syntax keyword qmlObjectType MaskShape
syntax keyword qmlObjectType Material
syntax keyword qmlObjectType Matrix4x4
syntax keyword qmlObjectType MediaPlayer
syntax keyword qmlObjectType mediaplayer-qml-dynamic
syntax keyword qmlObjectType MemoryBarrier
syntax keyword qmlObjectType Menu
syntax keyword qmlObjectType MenuBar
syntax keyword qmlObjectType MenuBarItem
syntax keyword qmlObjectType MenuBarStyle
syntax keyword qmlObjectType MenuItem
syntax keyword qmlObjectType MenuItemGroup
syntax keyword qmlObjectType MenuSeparator
syntax keyword qmlObjectType MenuStyle
syntax keyword qmlObjectType Mesh
syntax keyword qmlObjectType MessageDialog
syntax keyword qmlObjectType MetalRoughMaterial
syntax keyword qmlObjectType ModeKey
syntax keyword qmlObjectType Model
syntax keyword qmlObjectType MonthGrid
syntax keyword qmlObjectType MorphingAnimation
syntax keyword qmlObjectType MorphTarget
syntax keyword qmlObjectType MotionBlur
syntax keyword qmlObjectType MouseArea
syntax keyword qmlObjectType MouseDevice
syntax keyword qmlObjectType MouseEvent
syntax keyword qmlObjectType MouseHandler
syntax keyword qmlObjectType MultiPointHandler
syntax keyword qmlObjectType MultiPointTouchArea
syntax keyword qmlObjectType MultiSampleAntiAliasing

syntax keyword qmlObjectType Navigator
syntax keyword qmlObjectType NdefFilter
syntax keyword qmlObjectType NdefMimeRecord
syntax keyword qmlObjectType NdefRecord
syntax keyword qmlObjectType NdefTextRecord
syntax keyword qmlObjectType NdefUriRecord
syntax keyword qmlObjectType NearField
syntax keyword qmlObjectType Node
syntax keyword qmlObjectType NodeInstantiator
syntax keyword qmlObjectType NoDepthMask
syntax keyword qmlObjectType NoDraw
syntax keyword qmlObjectType NoPicking
syntax keyword qmlObjectType NormalDiffuseMapAlphaMaterial
syntax keyword qmlObjectType NormalDiffuseMapMaterial
syntax keyword qmlObjectType NormalDiffuseSpecularMapMaterial
syntax keyword qmlObjectType NumberAnimation nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType NumberKey

syntax keyword qmlObjectType Object3D
syntax keyword qmlObjectType ObjectModel
syntax keyword qmlObjectType ObjectPicker
syntax keyword qmlObjectType OpacityAnimator
syntax keyword qmlObjectType OpacityMask
syntax keyword qmlObjectType OpenGLInfo
syntax keyword qmlObjectType OrbitCameraController
syntax keyword qmlObjectType OrientationReading
syntax keyword qmlObjectType OrientationSensor
syntax keyword qmlObjectType OrthographicCamera
syntax keyword qmlObjectType Overlay

syntax keyword qmlObjectType Package
syntax keyword qmlObjectType Page
syntax keyword qmlObjectType PageIndicator
syntax keyword qmlObjectType Pane
syntax keyword qmlObjectType PaperArtisticMaterial
syntax keyword qmlObjectType PaperOfficeMaterial
syntax keyword qmlObjectType ParallelAnimation
syntax keyword qmlObjectType Parameter
syntax keyword qmlObjectType ParentAnimation
syntax keyword qmlObjectType ParentChange
syntax keyword qmlObjectType Particle
syntax keyword qmlObjectType ParticleExtruder
syntax keyword qmlObjectType ParticleGroup
syntax keyword qmlObjectType ParticlePainter
syntax keyword qmlObjectType ParticleSystem
syntax keyword qmlObjectType Pass
syntax keyword qmlObjectType Path
syntax keyword qmlObjectType PathAngleArc
syntax keyword qmlObjectType PathAnimation
syntax keyword qmlObjectType PathArc
syntax keyword qmlObjectType PathAttribute
syntax keyword qmlObjectType PathCubic
syntax keyword qmlObjectType PathCurve
syntax keyword qmlObjectType PathElement
syntax keyword qmlObjectType PathInterpolator
syntax keyword qmlObjectType PathLine
syntax keyword qmlObjectType PathMove
syntax keyword qmlObjectType PathMultiline
syntax keyword qmlObjectType PathPercent
syntax keyword qmlObjectType PathPolyline
syntax keyword qmlObjectType PathQuad
syntax keyword qmlObjectType PathSvg
syntax keyword qmlObjectType PathText
syntax keyword qmlObjectType PathView
syntax keyword qmlObjectType PauseAnimation
syntax keyword qmlObjectType PdfDocument
syntax keyword qmlObjectType PdfLinkModel
syntax keyword qmlObjectType PdfNavigationStack
syntax keyword qmlObjectType PdfSearchModel
syntax keyword qmlObjectType PdfSelection
syntax keyword qmlObjectType PercentBarSeries
syntax keyword qmlObjectType PerspectiveCamera
syntax keyword qmlObjectType PerVertexColorMaterial
syntax keyword qmlObjectType PhongAlphaMaterial
syntax keyword qmlObjectType PhongMaterial
syntax keyword qmlObjectType PickEvent
syntax keyword qmlObjectType PickingSettings
syntax keyword qmlObjectType PickLineEvent
syntax keyword qmlObjectType PickPointEvent
syntax keyword qmlObjectType PickResult
syntax keyword qmlObjectType PickTriangleEvent
syntax keyword qmlObjectType Picture
syntax keyword qmlObjectType PieMenu
syntax keyword qmlObjectType PieMenuStyle
syntax keyword qmlObjectType PieSeries
syntax keyword qmlObjectType PieSlice
syntax keyword qmlObjectType PinchArea
syntax keyword qmlObjectType PinchEvent
syntax keyword qmlObjectType PinchHandler
syntax keyword qmlObjectType Place
syntax keyword qmlObjectType PlaceAttribute
syntax keyword qmlObjectType PlaceSearchModel
syntax keyword qmlObjectType PlaceSearchSuggestionModel
syntax keyword qmlObjectType PlaneGeometry
syntax keyword qmlObjectType PlaneMesh
syntax keyword qmlObjectType PlasticStructuredRedEmissiveMaterial
syntax keyword qmlObjectType PlasticStructuredRedMaterial
syntax keyword qmlObjectType Playlist
syntax keyword qmlObjectType PlaylistItem
syntax keyword qmlObjectType PlayVariation
syntax keyword qmlObjectType Plugin
syntax keyword qmlObjectType PluginParameter
syntax keyword qmlObjectType PointDirection
syntax keyword qmlObjectType PointerDevice
syntax keyword qmlObjectType PointerDeviceHandler
syntax keyword qmlObjectType PointerEvent
syntax keyword qmlObjectType PointerHandler
syntax keyword qmlObjectType PointerScrollEvent
syntax keyword qmlObjectType PointHandler
syntax keyword qmlObjectType PointLight
syntax keyword qmlObjectType PointSize
syntax keyword qmlObjectType PolarChartView
syntax keyword qmlObjectType PolygonOffset
syntax keyword qmlObjectType Popup
syntax keyword qmlObjectType Position
syntax keyword qmlObjectType Positioner
syntax keyword qmlObjectType PositionSource
syntax keyword qmlObjectType PressureReading
syntax keyword qmlObjectType PressureSensor
syntax keyword qmlObjectType PrincipledMaterial
syntax keyword qmlObjectType Product
syntax keyword qmlObjectType ProgressBar
syntax keyword qmlObjectType ProgressBarStyle
syntax keyword qmlObjectType PropertyAction
syntax keyword qmlObjectType PropertyAnimation nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType PropertyChanges
syntax keyword qmlObjectType ProximityFilter
syntax keyword qmlObjectType ProximityReading
syntax keyword qmlObjectType ProximitySensor

syntax keyword qmlObjectType QAbstractState
syntax keyword qmlObjectType QAbstractTransition
syntax keyword qmlObjectType QmlSensors
syntax keyword qmlObjectType QSignalTransition
syntax keyword qmlObjectType Qt
syntax keyword qmlObjectType QtMultimedia
syntax keyword qmlObjectType QtObject
syntax keyword qmlObjectType QtPositioning
syntax keyword qmlObjectType QtRemoteObjects
syntax keyword qmlObjectType QuaternionAnimation
syntax keyword qmlObjectType QuotaRequest

syntax keyword qmlObjectType RadialBlur
syntax keyword qmlObjectType RadialGradient
syntax keyword qmlObjectType Radio
syntax keyword qmlObjectType RadioButton
syntax keyword qmlObjectType RadioButtonStyle
syntax keyword qmlObjectType RadioData
syntax keyword qmlObjectType RadioDelegate
syntax keyword qmlObjectType RangeSlider
syntax keyword qmlObjectType RasterMode
syntax keyword qmlObjectType Ratings
syntax keyword qmlObjectType RayCaster
syntax keyword qmlObjectType Rectangle
syntax keyword qmlObjectType RectangleShape
syntax keyword qmlObjectType RectangularGlow
syntax keyword qmlObjectType RecursiveBlur
syntax keyword qmlObjectType RegExpValidator
syntax keyword qmlObjectType RegisterProtocolHandlerRequest
syntax keyword qmlObjectType RegularExpressionValidator
syntax keyword qmlObjectType RenderCapabilities
syntax keyword qmlObjectType RenderCapture
syntax keyword qmlObjectType RenderCaptureReply
syntax keyword qmlObjectType RenderPass
syntax keyword qmlObjectType RenderPassFilter
syntax keyword qmlObjectType RenderSettings
syntax keyword qmlObjectType RenderState
syntax keyword qmlObjectType RenderStateSet
syntax keyword qmlObjectType RenderStats
syntax keyword qmlObjectType RenderSurfaceSelector
syntax keyword qmlObjectType RenderTarget
syntax keyword qmlObjectType RenderTargetOutput
syntax keyword qmlObjectType RenderTargetSelector
syntax keyword qmlObjectType Repeater
syntax keyword qmlObjectType Repeater3D
syntax keyword qmlObjectType ReviewModel
syntax keyword qmlObjectType Rotation
syntax keyword qmlObjectType RotationAnimation nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType RotationAnimator
syntax keyword qmlObjectType RotationReading
syntax keyword qmlObjectType RotationSensor
syntax keyword qmlObjectType RoundButton
syntax keyword qmlObjectType Route
syntax keyword qmlObjectType RouteLeg
syntax keyword qmlObjectType RouteManeuver
syntax keyword qmlObjectType RouteModel
syntax keyword qmlObjectType RouteQuery
syntax keyword qmlObjectType RouteSegment
syntax keyword qmlObjectType Row
syntax keyword qmlObjectType RowLayout

syntax keyword qmlObjectType Scale
syntax keyword qmlObjectType ScaleAnimator
syntax keyword qmlObjectType Scatter
syntax keyword qmlObjectType Scatter3D
syntax keyword qmlObjectType Scatter3DSeries
syntax keyword qmlObjectType ScatterDataProxy
syntax keyword qmlObjectType ScatterSeries
syntax keyword qmlObjectType Scene2D
syntax keyword qmlObjectType Scene3D
syntax keyword qmlObjectType Scene3DView
syntax keyword qmlObjectType SceneEnvironment
syntax keyword qmlObjectType SceneLoader
syntax keyword qmlObjectType ScissorTest
syntax keyword qmlObjectType Screen
syntax keyword qmlObjectType ScreenRayCaster
syntax keyword qmlObjectType ScriptAction
syntax keyword qmlObjectType ScrollBar
syntax keyword qmlObjectType ScrollIndicator
syntax keyword qmlObjectType ScrollView
syntax keyword qmlObjectType ScrollViewStyle
syntax keyword qmlObjectType SCurveTonemap
syntax keyword qmlObjectType ScxmlStateMachine
syntax keyword qmlObjectType SeamlessCubemap
syntax keyword qmlObjectType SelectionListItem
syntax keyword qmlObjectType SelectionListModel
syntax keyword qmlObjectType Sensor
syntax keyword qmlObjectType SensorGesture
syntax keyword qmlObjectType SensorReading
syntax keyword qmlObjectType SequentialAnimation
syntax keyword qmlObjectType Settings
syntax keyword qmlObjectType SettingsStore
syntax keyword qmlObjectType SetUniformValue
syntax keyword qmlObjectType Shader
syntax keyword qmlObjectType ShaderEffect
syntax keyword qmlObjectType ShaderEffectSource
syntax keyword qmlObjectType ShaderImage
syntax keyword qmlObjectType ShaderInfo
syntax keyword qmlObjectType ShaderProgram
syntax keyword qmlObjectType ShaderProgramBuilder
syntax keyword qmlObjectType Shape
syntax keyword qmlObjectType ShapeGradient
syntax keyword qmlObjectType ShapePath
syntax keyword qmlObjectType SharedGLTexture
syntax keyword qmlObjectType ShellSurface
syntax keyword qmlObjectType ShellSurfaceItem
syntax keyword qmlObjectType ShiftHandler
syntax keyword qmlObjectType ShiftKey
syntax keyword qmlObjectType Shortcut
syntax keyword qmlObjectType SignalSpy
syntax keyword qmlObjectType SignalTransition
syntax keyword qmlObjectType SinglePointHandler
syntax keyword qmlObjectType Skeleton
syntax keyword qmlObjectType SkeletonLoader
syntax keyword qmlObjectType SkyboxEntity
syntax keyword qmlObjectType Slider
syntax keyword qmlObjectType SliderStyle
syntax keyword qmlObjectType SmoothedAnimation
syntax keyword qmlObjectType SortPolicy
syntax keyword qmlObjectType Sound
syntax keyword qmlObjectType SoundEffect
syntax keyword qmlObjectType SoundInstance
syntax keyword qmlObjectType SpaceKey
syntax keyword qmlObjectType SphereGeometry
syntax keyword qmlObjectType SphereMesh
syntax keyword qmlObjectType SpinBox
syntax keyword qmlObjectType SpinBoxStyle
syntax keyword qmlObjectType SplineSeries
syntax keyword qmlObjectType SplitHandle
syntax keyword qmlObjectType SplitView
syntax keyword qmlObjectType SpotLight
syntax keyword qmlObjectType SpringAnimation
syntax keyword qmlObjectType Sprite
syntax keyword qmlObjectType SpriteGoal
syntax keyword qmlObjectType SpriteSequence
syntax keyword qmlObjectType Stack
syntax keyword qmlObjectType StackedBarSeries
syntax keyword qmlObjectType StackLayout
syntax keyword qmlObjectType StackView
syntax keyword qmlObjectType StackViewDelegate
syntax keyword qmlObjectType StandardPaths
syntax keyword qmlObjectType State
syntax keyword qmlObjectType StateChangeScript
syntax keyword qmlObjectType StateGroup
syntax keyword qmlObjectType StateMachine
syntax keyword qmlObjectType StateMachineLoader
syntax keyword qmlObjectType StatusBar
syntax keyword qmlObjectType StatusBarStyle
syntax keyword qmlObjectType StatusIndicator
syntax keyword qmlObjectType StatusIndicatorStyle
syntax keyword qmlObjectType SteelMilledConcentricMaterial
syntax keyword qmlObjectType StencilMask
syntax keyword qmlObjectType StencilOperation
syntax keyword qmlObjectType StencilOperationArguments
syntax keyword qmlObjectType StencilTest
syntax keyword qmlObjectType StencilTestArguments
syntax keyword qmlObjectType Store
syntax keyword qmlObjectType SubtreeEnabler
syntax keyword qmlObjectType Supplier
syntax keyword qmlObjectType Surface3D
syntax keyword qmlObjectType Surface3DSeries
syntax keyword qmlObjectType SurfaceDataProxy
syntax keyword qmlObjectType SwipeDelegate
syntax keyword qmlObjectType SwipeView
syntax keyword qmlObjectType Switch
syntax keyword qmlObjectType SwitchDelegate
syntax keyword qmlObjectType SwitchStyle
syntax keyword qmlObjectType SymbolModeKey
syntax keyword qmlObjectType SystemPalette
syntax keyword qmlObjectType SystemTrayIcon

syntax keyword qmlObjectType Tab
syntax keyword qmlObjectType TabBar
syntax keyword qmlObjectType TabButton
syntax keyword qmlObjectType TableModel
syntax keyword qmlObjectType TableModelColumn
syntax keyword qmlObjectType TableView
syntax keyword qmlObjectType TableViewColumn
syntax keyword qmlObjectType TableViewStyle
syntax keyword qmlObjectType TabView
syntax keyword qmlObjectType TabViewStyle
syntax keyword qmlObjectType TapHandler
syntax keyword qmlObjectType TapReading
syntax keyword qmlObjectType TapSensor
syntax keyword qmlObjectType TargetDirection
syntax keyword qmlObjectType TaskbarButton
syntax keyword qmlObjectType Technique
syntax keyword qmlObjectType TechniqueFilter
syntax keyword qmlObjectType TestCase
syntax keyword qmlObjectType Text
syntax keyword qmlObjectType Text2DEntity
syntax keyword qmlObjectType TextArea
syntax keyword qmlObjectType TextAreaStyle
syntax keyword qmlObjectType TextEdit
syntax keyword qmlObjectType TextField
syntax keyword qmlObjectType TextFieldStyle
syntax keyword qmlObjectType TextInput
syntax keyword qmlObjectType TextMetrics
syntax keyword qmlObjectType Texture
syntax keyword qmlObjectType Texture1D
syntax keyword qmlObjectType Texture1DArray
syntax keyword qmlObjectType Texture2D
syntax keyword qmlObjectType Texture2DArray
syntax keyword qmlObjectType Texture2DMultisample
syntax keyword qmlObjectType Texture2DMultisampleArray
syntax keyword qmlObjectType Texture3D
syntax keyword qmlObjectType TextureBuffer
syntax keyword qmlObjectType TextureCubeMap
syntax keyword qmlObjectType TextureCubeMapArray
syntax keyword qmlObjectType TextureImage
syntax keyword qmlObjectType TextureInput
syntax keyword qmlObjectType TextureLoader
syntax keyword qmlObjectType TextureRectangle
syntax keyword qmlObjectType Theme3D
syntax keyword qmlObjectType ThemeColor
syntax keyword qmlObjectType ThresholdMask
syntax keyword qmlObjectType ThumbnailToolBar
syntax keyword qmlObjectType ThumbnailToolButton
syntax keyword qmlObjectType TiltReading
syntax keyword qmlObjectType TiltSensor
syntax keyword qmlObjectType TiltShift
syntax keyword qmlObjectType Timeline
syntax keyword qmlObjectType TimelineAnimation
syntax keyword qmlObjectType TimeoutTransition
syntax keyword qmlObjectType Timer
syntax keyword qmlObjectType ToggleButton
syntax keyword qmlObjectType ToggleButtonStyle
syntax keyword qmlObjectType ToolBar
syntax keyword qmlObjectType ToolBarStyle
syntax keyword qmlObjectType ToolButton
syntax keyword qmlObjectType ToolSeparator
syntax keyword qmlObjectType ToolTip
syntax keyword qmlObjectType TooltipRequest
syntax keyword qmlObjectType Torch
syntax keyword qmlObjectType TorusGeometry
syntax keyword qmlObjectType TorusMesh
syntax keyword qmlObjectType TouchEventSequence
syntax keyword qmlObjectType TouchInputHandler3D
syntax keyword qmlObjectType TouchPoint
syntax keyword qmlObjectType Trace
syntax keyword qmlObjectType TraceCanvas
syntax keyword qmlObjectType TraceInputArea
syntax keyword qmlObjectType TraceInputKey
syntax keyword qmlObjectType TraceInputKeyPanel
syntax keyword qmlObjectType TrailEmitter
syntax keyword qmlObjectType Transaction
syntax keyword qmlObjectType Transform
syntax keyword qmlObjectType Transition
syntax keyword qmlObjectType Translate
syntax keyword qmlObjectType TreeView
syntax keyword qmlObjectType TreeViewStyle
syntax keyword qmlObjectType Tumbler
syntax keyword qmlObjectType TumblerColumn
syntax keyword qmlObjectType TumblerStyle
syntax keyword qmlObjectType Turbulence

syntax keyword qmlObjectType UniformAnimator
syntax keyword qmlObjectType User

syntax keyword qmlObjectType ValueAxis
syntax keyword qmlObjectType ValueAxis3D
syntax keyword qmlObjectType ValueAxis3DFormatter
syntax keyword qmlObjectType VBarModelMapper
syntax keyword qmlObjectType VBoxPlotModelMapper
syntax keyword qmlObjectType VCandlestickModelMapper
syntax keyword qmlObjectType Vector3dAnimation nextgroup=qmlPropModifierOn
syntax keyword qmlObjectType VertexBlendAnimation
syntax keyword qmlObjectType VerticalHeaderView
syntax keyword qmlObjectType Video
syntax keyword qmlObjectType VideoOutput
syntax keyword qmlObjectType View3D
syntax keyword qmlObjectType Viewport
syntax keyword qmlObjectType ViewTransition
syntax keyword qmlObjectType Vignette
syntax keyword qmlObjectType VirtualKeyboardSettings
syntax keyword qmlObjectType VPieModelMapper
syntax keyword qmlObjectType VXYModelMapper

syntax keyword qmlObjectType Wander
syntax keyword qmlObjectType WasdController
syntax keyword qmlObjectType WavefrontMesh
syntax keyword qmlObjectType WaylandClient
syntax keyword qmlObjectType WaylandCompositor
syntax keyword qmlObjectType WaylandHardwareLayer
syntax keyword qmlObjectType WaylandOutput
syntax keyword qmlObjectType WaylandQuickItem
syntax keyword qmlObjectType WaylandSeat
syntax keyword qmlObjectType WaylandSurface
syntax keyword qmlObjectType WaylandView
syntax keyword qmlObjectType Waypoint
syntax keyword qmlObjectType WebChannel
syntax keyword qmlObjectType WebEngine
syntax keyword qmlObjectType WebEngineAction
syntax keyword qmlObjectType WebEngineCertificateError
syntax keyword qmlObjectType WebEngineClientCertificateOption
syntax keyword qmlObjectType WebEngineClientCertificateSelection
syntax keyword qmlObjectType WebEngineDownloadItem
syntax keyword qmlObjectType WebEngineHistory
syntax keyword qmlObjectType WebEngineHistoryListModel
syntax keyword qmlObjectType WebEngineLoadRequest
syntax keyword qmlObjectType WebEngineNavigationRequest
syntax keyword qmlObjectType WebEngineNewViewRequest
syntax keyword qmlObjectType WebEngineNotification
syntax keyword qmlObjectType WebEngineProfile
syntax keyword qmlObjectType WebEngineScript
syntax keyword qmlObjectType WebEngineSettings
syntax keyword qmlObjectType WebEngineView
syntax keyword qmlObjectType WebSocket
syntax keyword qmlObjectType WebSocketServer
syntax keyword qmlObjectType WebView
syntax keyword qmlObjectType WebViewLoadRequest
syntax keyword qmlObjectType WeekNumberColumn
syntax keyword qmlObjectType WheelEvent
syntax keyword qmlObjectType WheelHandler
syntax keyword qmlObjectType Window
syntax keyword qmlObjectType WlScaler
syntax keyword qmlObjectType WlShell
syntax keyword qmlObjectType WlShellSurface
syntax keyword qmlObjectType WorkerScript

syntax keyword qmlObjectType XAnimator
syntax keyword qmlObjectType XdgDecorationManagerV1
syntax keyword qmlObjectType XdgOutputManagerV1
syntax keyword qmlObjectType XdgPopup
syntax keyword qmlObjectType XdgPopupV5
syntax keyword qmlObjectType XdgPopupV6
syntax keyword qmlObjectType XdgShell
syntax keyword qmlObjectType XdgShellV5
syntax keyword qmlObjectType XdgShellV6
syntax keyword qmlObjectType XdgSurface
syntax keyword qmlObjectType XdgSurfaceV5
syntax keyword qmlObjectType XdgSurfaceV6
syntax keyword qmlObjectType XdgToplevel
syntax keyword qmlObjectType XdgToplevelV6
syntax keyword qmlObjectType XmlListModel
syntax keyword qmlObjectType XmlRole
syntax keyword qmlObjectType XYPoint
syntax keyword qmlObjectType XYSeries

syntax keyword qmlObjectType YAnimator

syntax keyword qmlObjectType ZoomBlur

" }}}

if get(g:, 'qml_fold', 0)
  syn match   qmlFunction      "\<function\>"
  syn region  qmlFunctionFold  start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

  syn sync match qmlSync  grouphere qmlFunctionFold "\<function\>"
  syn sync match qmlSync  grouphere NONE "^}"

  setlocal foldmethod=syntax
  setlocal foldtext=getline(v:foldstart)
else
  syn keyword qmlFunction         function
  syn match   qmlArrowFunction    "=>"
  syn match   qmlBraces           "[{}\[\]]"
  syn match   qmlParens           "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "qml"
  syn sync ccomment qmlComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_qml_syn_inits")
  if version < 508
    let did_qml_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink qmlComment             Comment
  HiLink qmlLineComment         Comment
  HiLink qmlCommentTodo         Todo
  HiLink qmlSpecial             Special
  HiLink qmlStringS             String
  HiLink qmlStringD             String
  HiLink qmlStringT             String
  HiLink qmlCharacter           Character
  HiLink qmlNumber              Number
  HiLink qmlConditional         Conditional
  HiLink qmlRepeat              Repeat
  HiLink qmlBranch              Conditional
  HiLink qmlOperator            Operator
  HiLink qmlBasicType           Type
  HiLink qmlJsType              Type
  HiLink qmlObjectType          Type
  HiLink qmlAliasType           Type
  HiLink qmlObjectDefinition    Type
  HiLink qmlPropModifierOn      Function
  HiLink qmlPropModifierTarget  Label
  HiLink qmlStatement           Statement
  HiLink qmlFunction            Function
  HiLink qmlArrowFunction       Function
  HiLink qmlBraces              Function
  HiLink qmlError               Error
  HiLink qmlNull                Keyword
  HiLink qmlBoolean             Boolean
  HiLink qmlRegexpString        String

  HiLink qmlIdentifier        Identifier
  HiLink qmlLabel             Label
  HiLink qmlException         Exception
  HiLink qmlMessage           Keyword
  HiLink qmlGlobal            Keyword
  HiLink qmlReserved          Keyword
  HiLink qmlDebug             Debug
  HiLink qmlConstant          Label
  HiLink qmlPropertyName      Label
  HiLink qmlGroupProperty     Label
  HiLink qmlDeclaration       Function

  delcommand HiLink
endif

let b:current_syntax = "qml"
if main_syntax == 'qml'
  unlet main_syntax
endif
