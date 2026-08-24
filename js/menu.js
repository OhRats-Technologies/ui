(function () {
    const desktop = window.matchMedia("(min-width: 1024px)");

    function closeMenu(button, menu) {
        menu.classList.remove("open");
        button.setAttribute("aria-expanded", "false");
    }

    function bind() {
        document.querySelectorAll("[data-menu-toggle]").forEach((button) => {
            const targetId = button.getAttribute("aria-controls");
            const menu = targetId && document.getElementById(targetId);
            if (!menu) return;

            if (desktop.matches) closeMenu(button, menu);

            button.addEventListener("click", () => {
                const open = menu.classList.toggle("open");
                button.setAttribute("aria-expanded", String(open));
            });

            desktop.addEventListener("change", (event) => {
                if (event.matches) closeMenu(button, menu);
            });
        });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", bind, { once: true });
    } else {
        bind();
    }
})();
