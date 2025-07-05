<<<<<<< HEAD
import React from 'react';
import ReactDOM from 'react-dom/client';
=======
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
import './index.css';
import App from './App';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
import { fab } from '@fortawesome/free-brands-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';
import { isEnvBrowser } from './utils/misc';
import LocaleProvider from './providers/LocaleProvider';
import ConfigProvider from './providers/ConfigProvider';
<<<<<<< HEAD
=======
import ErrorBoundary from './providers/errorBoundary';
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

library.add(fas, far, fab);

if (isEnvBrowser()) {
  const root = document.getElementById('root');

  // https://i.imgur.com/iPTAdYV.png - Night time img
  root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
  root!.style.backgroundSize = 'cover';
  root!.style.backgroundRepeat = 'no-repeat';
  root!.style.backgroundPosition = 'center';
}

const root = document.getElementById('root');
<<<<<<< HEAD
ReactDOM.createRoot(root!).render(
  <React.StrictMode>
    <LocaleProvider>
      <ConfigProvider>
        <App />
      </ConfigProvider>
    </LocaleProvider>
  </React.StrictMode>
=======

createRoot(root!).render(
  <StrictMode>
    <LocaleProvider>
      <ConfigProvider>
        <ErrorBoundary>
          <App />
        </ErrorBoundary>
      </ConfigProvider>
    </LocaleProvider>
  </StrictMode>
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
);
