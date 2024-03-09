import { ViewHook } from "phoenix_live_view";

const CopyToClipboard = {
  mounted(this: ViewHook) {
    this.el.addEventListener("click", () => {
      const textToCopy = this.el.getAttribute("data-clipboard-gist");
      if (textToCopy) {
        navigator.clipboard
          .writeText(textToCopy)
          .then(() => {
            console.log("Copied to clipboard");
          })
          .catch((error) => console.error(error.message));
      }
    });
  },
};

export default CopyToClipboard;
