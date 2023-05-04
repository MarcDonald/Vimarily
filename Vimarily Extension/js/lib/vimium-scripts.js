/*
 * Code in this file is taken directly from vimium
 */

/*
 * A heads-up-display (HUD) for showing Vimium page operations.
 * Note: you cannot interact with the HUD until document.body is available.
 */
HUD = {
	_tweenId: -1,
	_displayElement: null,
	_upgradeNotificationElement: null,

	showForDuration: function (text, duration) {
		HUD.show(text);
		HUD._showForDurationTimerId = setTimeout(function () {
			HUD.hide();
		}, duration);
	},

	show: function (text) {
		clearTimeout(HUD._showForDurationTimerId);
		HUD.displayElement().innerHTML = text;
		clearInterval(HUD._tweenId);
		HUD._tweenId = Tween.fade(HUD.displayElement(), 1.0, 150);
		HUD.displayElement().style.display = '';
	},

	hideUpgradeNotification: function (clickEvent) {
		Tween.fade(HUD.upgradeNotificationElement(), 0, 150, function () {
			HUD.upgradeNotificationElement().style.display = 'none';
		});
	},

	updatePageZoomLevel: function (pageZoomLevel) {
		// Since the chrome HUD does not scale with the page's zoom level, neither will this HUD.
		const inverseZoomLevel = (100.0 / pageZoomLevel) * 100;
		if (HUD._displayElement)
			HUD.displayElement().style.zoom = inverseZoomLevel + '%';
		if (HUD._upgradeNotificationElement)
			HUD.upgradeNotificationElement().style.zoom = inverseZoomLevel + '%';
	},

	/*
	 * Retrieves the HUD HTML element.
	 */
	displayElement: function () {
		if (!HUD._displayElement) {
			HUD._displayElement = HUD.createHudElement();
			HUD.updatePageZoomLevel(currentZoomLevel);
		}
		return HUD._displayElement;
	},

	createHudElement: function () {
		const element = document.createElement('div');
		element.className = 'vimiumHUD';
		document.body.appendChild(element);
		return element;
	},

	hide: function () {
		clearInterval(HUD._tweenId);
		HUD._tweenId = Tween.fade(HUD.displayElement(), 0, 150, function () {
			HUD.displayElement().style.display = 'none';
		});
	},

	isReady: function () {
		return document.body != null;
	},
};

Tween = {
	/*
	 * Fades an element's alpha. Returns a timer ID which can be used to stop the tween via clearInterval.
	 */
	fade: function (element, toAlpha, duration, onComplete) {
		const state = {};
		state.duration = duration;
		state.startTime = new Date().getTime();
		state.from = parseInt(element.style.opacity) || 0;
		state.to = toAlpha;
		state.onUpdate = function (value) {
			element.style.opacity = value;
			if (value == state.to && onComplete) onComplete();
		};
		state.timerId = setInterval(function () {
			Tween.performTweenStep(state);
		}, 50);
		return state.timerId;
	},

	performTweenStep: function (state) {
		const elapsed = new Date().getTime() - state.startTime;
		if (elapsed >= state.duration) {
			clearInterval(state.timerId);
			state.onUpdate(state.to);
		} else {
			const value =
				(elapsed / state.duration) * (state.to - state.from) + state.from;
			state.onUpdate(value);
		}
	},
};
