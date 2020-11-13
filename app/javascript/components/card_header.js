import Typed from 'typed.js';

const loadDynamicCardHeaderText = () => {
  new Typed('#card-header-typed-text', {
    strings: ["Add a Dose, my friend !"],
    typeSpeed: 70,
    loop: true
  });
}

export { loadDynamicCardHeaderText };
