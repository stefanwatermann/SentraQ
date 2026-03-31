// CartItem Button Handler
function cartItemButtonClick(button, rowIndex, action, cntrlId) {
    console.log("cartItemButtonClick", button, rowIndex, action, cntrlId);
    var obj = new XojoWeb.JSONItem;
    obj.set('row', rowIndex);
    obj.set('column', 0);
    obj.set('identifier', action);
    obj.set('value', rowIndex);
    XojoWeb.controls.lookup(cntrlId).triggerServerEvent('CustomCellAction', obj);
}

// StationListMenu
function SelectWebMenuItem(sender) {
  let elems = sender.parentElement.getElementsByClassName("list-group-item-action");
  for (const el of elems) {
    el.classList.remove("active");
  }
  sender.classList.add("active");
}