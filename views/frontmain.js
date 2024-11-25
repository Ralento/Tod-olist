document.addEventListener('DOMContentLoaded', function () {
  const menuIcono = document.getElementById('menu-icono');
  const barraLateral = document.getElementById('barra-lateral');
  const cerrarLateral = document.getElementById('cerrar-lateral');

  menuIcono.addEventListener('click', () => {
      barraLateral.classList.add('mostrar');
  });

  cerrarLateral.addEventListener('click', () => {
      barraLateral.classList.remove('mostrar');
  });
});
