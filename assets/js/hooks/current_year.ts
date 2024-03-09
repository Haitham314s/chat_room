import { ViewHook } from "phoenix_live_view";

const CurrentYear = {
  mounted(this: ViewHook) {
    const currentYear = new Date().getUTCFullYear();
    this.el.innerText = currentYear.toString();
  },
};

export default CurrentYear;
