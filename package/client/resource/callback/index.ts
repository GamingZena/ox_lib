import { cache } from '../cache';

<<<<<<< HEAD
const activeEvents: Record<string, (...args: any[]) => void> = {};

onNet(`__ox_cb_${cache.resource}`, (key: string, ...args: any) => {
  const resolve = activeEvents[key];
  return resolve && resolve(...args);
=======
const pendingCallbacks: Record<string, (...args: any[]) => void> = {};
const callbackTimeout = GetConvarInt('ox:callbackTimeout', 300000);

onNet(`__ox_cb_${cache.resource}`, (key: string, ...args: any) => {
  if (!source) return;

  const resolve = pendingCallbacks[key];

  if (!resolve) return;

  delete pendingCallbacks[key];

  resolve(...args);
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
});

const eventTimers: Record<string, number> = {};

export function eventTimer(eventName: string, delay: number | null) {
  if (delay && delay > 0) {
    const currentTime = GetGameTimer();

    if ((eventTimers[eventName] || 0) > currentTime) return false;

    eventTimers[eventName] = currentTime + delay;
  }

  return true;
}

export function triggerServerCallback<T = unknown>(
  eventName: string,
  delay: number | null,
  ...args: any
): Promise<T> | void {
  if (!eventTimer(eventName, delay)) return;

  let key: string;

  do {
    key = `${eventName}:${Math.floor(Math.random() * (100000 + 1))}`;
<<<<<<< HEAD
  } while (activeEvents[key]);

  emitNet(`__ox_cb_${eventName}`, cache.resource, key, ...args);

  return new Promise<T>((resolve) => {
    activeEvents[key] = resolve;
=======
  } while (pendingCallbacks[key]);

  emitNet(`ox_lib:validateCallback`, eventName, cache.resource, key);
  emitNet(`__ox_cb_${eventName}`, cache.resource, key, ...args);

  return new Promise<T>((resolve, reject) => {
    pendingCallbacks[key] = (args) => {
      if (args[0] === 'cb_invalid') reject(`callback '${eventName} does not exist`);

      resolve(args);
    };

    setTimeout(reject, callbackTimeout, `callback event '${key}' timed out`);
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  });
}

export function onServerCallback(eventName: string, cb: (...args: any[]) => any) {
<<<<<<< HEAD
=======
  exports.ox_lib.setValidCallback(eventName, true)

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  onNet(`__ox_cb_${eventName}`, async (resource: string, key: string, ...args: any[]) => {
    let response: any;

    try {
      response = await cb(...args);
    } catch (e: any) {
      console.error(`an error occurred while handling callback event ${eventName}`);
      console.log(`^3${e.stack}^0`);
    }

    emitNet(`__ox_cb_${resource}`, key, response);
  });
}
