# heart_popup API Reference
Generated: 2026-05-20

a node that can be attached and used to display how much health something has, can work with other stats too

## Class: HeartPopUp
**Inherits:** [Sprite2D](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html)


### ⚙️ Inspector Variables (Exported)
| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| **_visible** | `bool` | `true` | Whether the popup is currently visible (scaled to 1) or hidden (scaled to 0) |
| **popup_speed** | `float` | `10` | SmoothMovement speed for the scale-in / scale-out animation |
| **health** | `int` | `100` | The number displayed on the popup label |
| **text_size** | `float` | `0.8` | Label size as a fraction of the sprite's dimensions (1.0 = fill sprite) |

### 🔔 Signals
| Signal | Arguments | Description |
| :--- | :--- | :--- |
| **popup_shown** | - |  Emitted when the popup becomes visible |
| **popup_hidden** | - |  Emitted when the popup finishes its display duration and hides |

### 🛠️ Methods
| Method | Arguments | Returns | Description |
| :--- | :--- | :--- | :--- |
| **static func init()** | `sprite:Texture2D`<br>`parent:Node2D`<br>`_position:Vector2` | `HeartPopUp` |  Factory: creates a HeartPopUp, attaches it to parent at _position, and assigns the icon texture |
| **popup()** | `time: float` | `void` |  Shows the popup for `time` seconds, then hides it via a one-shot timer |

---

