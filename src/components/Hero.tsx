import React from 'react';

const Hero: React.FC = () => {
  return (
    <section className="relative hachiran-hero py-20 px-4">
      <div className="max-w-4xl mx-auto text-center">
        <img
          src="/logo.jpg"
          alt="Hachiran Ramen logo"
          className="mx-auto mb-6 w-28 h-28 rounded object-cover ring-2 ring-ramen-gold shadow-md"
          onError={(e) => { (e.currentTarget as HTMLImageElement).src = '/logo.jpg'; }}
        />
        <h1 className="text-5xl md:text-6xl font-noto-kr font-semibold text-white drop-shadow mb-4 animate-fade-in">
          Hachiran Ramen
        </h1>
        <p className="text-xl text-white/90 mb-8 max-w-2xl mx-auto animate-slide-up">
          I ♥ Hachiran Ramen — bold flavors, springy noodles, made with love.
        </p>
        <div className="flex justify-center">
          <a 
            href="#ramen"
            className="bg-white text-ramen-red px-8 py-3 rounded-full hover:bg-ramen-cream transition-all duration-300 transform hover:scale-105 font-medium shadow"
          >
            Explore Menu
          </a>
        </div>
      </div>
    </section>
  );
};

export default Hero;