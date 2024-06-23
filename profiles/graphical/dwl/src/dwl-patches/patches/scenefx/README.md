### Description
Implement https://github.com/wlrfx/scenefx (commit de4ec10e1ff9347b5833f00f8615d760d9378c99) in DWL.

```c
/* available options */

static const int opacity = 0; /* flag to enable opacity */
static const float opacity_inactive = 0.5;
static const float opacity_active = 1.0;

static const int shadow = 1; /* flag to enable shadow */
static const int shadow_only_floating = 0; /* only apply shadow to floating windows */
static const struct wlr_render_color shadow_color = COLOR(0x0000FFff);
static const struct wlr_render_color shadow_color_focus = COLOR(0xFF0000ff);
static const int shadow_blur_sigma = 20;
static const int shadow_blur_sigma_focus = 40;
static const char *const shadow_ignore_list[] = { "xdg-desktop-portal-gtk", NULL }; /* list of app-id to ignore */

static const int corner_radius = 0; /* 0 disables corner_radius */

static const int blur = 1; /* flag to enable blur */
static const int blur_optimized = 1;
static const int blur_ignore_transparent = 1;
static const struct blur_data blur_data = {
	.radius = 5,
	.num_passes = 3,
	.noise = 0.02,
	.brightness = 0.9,
	.contrast = 0.9,
	.saturation = 1.1,
};
```

> **NOTE:** If you are using nix, I have packaged scenefx https://github.com/wochap/nix-config/blob/main/packages/scenefx/default.nix

> **NOTE:** Some GTK apps are being cut off when they have shadows enabled. You can use the `shadow_ignore_list` option to prevent shadows from being rendered on those apps

> **NOTE:** Blur doesn't work on windows with opacity set (opacity_active, opacity_inactive)

> **NOTE:** In DWL's Makefile `scenefx` must be placed before wlroots, e.g. `PKGS = scenefx wlroots wayland-server ...`

**IMPORTANT:** This patch requires you to build DWL with the dependencies of WLROOTS:
* **scenefx**
* libGL
* libcap
* libinput
* libpng
* libxkbcommon
* mesa
* pixman
* seatd
* vulkan-loader
* wayland
* wayland-protocols
* xorg.libX11
* xorg.xcbutilerrors
* xorg.xcbutilimage
* xorg.xcbutilrenderutil
* xorg.xcbutilwm
* xwayland (optional)
* ffmpeg
* hwdata
* libliftoff
* libdisplay-info

<details>
<summary>Preview</summary>
<pre>
<img src="https://i.imgur.com/4kFhSaS.png"/>
<img src="https://i.imgur.com/9ZQAUXx.png"/>
</pre>
</details>

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/scenefx)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/6e3a57ffd16dafa31900b7e89e51672bd7bcc1e8/scenefx/scenefx.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/7a5c3420822074c544fa102e030b7c30aa6b6be8/scenefx/scenefx.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
