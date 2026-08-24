(function () {
    const root = document.documentElement;
    const storageKey = "theme";
    const cookieKey = "ohrats_theme";
    const cookieDomain = "ohrats.party";
    const media = window.matchMedia("(prefers-color-scheme: dark)");

    const icons = {
        dark: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>',
        light: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>'
    };

    function cookieTheme() {
        const prefix = `${cookieKey}=`;
        const value = document.cookie
            .split("; ")
            .find((entry) => entry.startsWith(prefix))
            ?.slice(prefix.length);

        return value === "dark" || value === "light" ? value : null;
    }

    function localTheme() {
        try {
            const value = localStorage.getItem(storageKey);
            return value === "dark" || value === "light" ? value : null;
        } catch (_) {
            return null;
        }
    }

    function savedTheme() {
        return cookieTheme() || localTheme();
    }

    function canShareCookie() {
        return location.hostname === cookieDomain || location.hostname.endsWith(`.${cookieDomain}`);
    }

    function persistTheme(theme) {
        try {
            localStorage.setItem(storageKey, theme);
        } catch (_) {}

        if (canShareCookie()) {
            document.cookie = `${cookieKey}=${theme}; Path=/; Domain=${cookieDomain}; Max-Age=31536000; SameSite=Lax; Secure`;
        }
    }

    function render() {
        const isDark = root.classList.contains("dark");
        document.querySelectorAll("[data-theme-toggle]").forEach((button) => {
            button.innerHTML = isDark ? icons.dark : icons.light;
            button.setAttribute("aria-label", isDark ? "Use light theme" : "Use dark theme");
            button.setAttribute("aria-pressed", String(isDark));
        });
    }

    function apply(theme, persist) {
        const isDark = theme === "dark";
        root.classList.toggle("dark", isDark);
        root.dataset.theme = isDark ? "dark" : "light";

        if (persist) {
            persistTheme(isDark ? "dark" : "light");
        }

        render();
        window.dispatchEvent(new CustomEvent("ohrats:theme", { detail: { theme: root.dataset.theme } }));
    }

    function preferredTheme() {
        const saved = savedTheme();
        return saved === "dark" || saved === "light" ? saved : (media.matches ? "dark" : "light");
    }

    function syncSharedTheme() {
        const shared = cookieTheme();
        if (shared && shared !== root.dataset.theme) apply(shared, true);
    }

    function bind() {
        render();
        document.querySelectorAll("[data-theme-toggle]").forEach((button) => {
            button.addEventListener("click", () => {
                apply(root.classList.contains("dark") ? "light" : "dark", true);
            });
        });
    }

    const saved = savedTheme();
    const initial = saved || preferredTheme();
    if (saved && canShareCookie()) persistTheme(saved);
    apply(initial, false);

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", bind, { once: true });
    } else {
        bind();
    }

    media.addEventListener("change", () => {
        if (!savedTheme()) apply(media.matches ? "dark" : "light", false);
    });

    window.addEventListener("focus", syncSharedTheme);
    document.addEventListener("visibilitychange", () => {
        if (!document.hidden) syncSharedTheme();
    });

    window.OhRatsTheme = { apply };
})();
