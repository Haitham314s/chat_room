import { ViewHook } from "phoenix_live_view";

const ToggleEdit = {
  mounted(this: ViewHook) {
    this.el.addEventListener("click", () => {
      const edit = document.querySelector("#edit-section");
      const syntax = document.querySelector("#syntax-section");
      if (edit && syntax) {
        edit.className = "block";
        syntax.className = "hidden";
      }
    });
  },
};

export default ToggleEdit;
