function bigImg(x) {
    x.style.height = "64px";
    x.style.width = "64px";
}

function normalImg(x) {
    x.style.height = "32px";
    x.style.width = "32px";
}

// function switchMenu( theMainMenu, theSubMenu, theEvent ){
//     var SubMenu = document.getElementById( theSubMenu );
//     if( SubMenu.style.display == 'none' ){ // 顯示子選單
//         SubMenu.style.minWidth = theMainMenu.clientWidth; // 讓子選單的最小寬度與主選單相同 (僅為了美觀)
//         SubMenu.style.display = 'block';
//         hideMenu(); // 隱藏子選單
//         VisibleMenu = theSubMenu;
//     }
//     else{ // 隱藏子選單
//         if( theEvent != 'MouseOver' || VisibleMenu != theSubMenu ){
//             SubMenu.style.display = 'none';
//             VisibleMenu = '';
//         }
//     }
// }

// // 隱藏子選單
// function hideMenu(){
//     if( VisibleMenu != '' ){
//         document.getElementById( VisibleMenu ).style.display = 'none';
//     }
//     VisibleMenu = '';
// }