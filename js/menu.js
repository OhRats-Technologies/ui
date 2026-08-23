(function () {
    function bind() {
        document.querySelectorAll("[data-menu-toggle]").forEach((button) => {
            const targetId = button.getAttribute("aria-controls");
            const menu = targetId && document.getElementById(targetId);
            if (!menu) return;

            button.addEventListener("click", () => {
                const open = menu.classList.toggle("open");
                button.setAttribute("aria-expanded", String(open));
            });
        });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", bind, { once: true });
    } else {
        bind();
    }
})();
