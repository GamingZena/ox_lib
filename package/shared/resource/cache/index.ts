<<<<<<< HEAD
export const cache: Record<string, any> = new Proxy(
  {
    resource: GetCurrentResourceName(),
=======
interface OxCache {
  ped: number;
  vehicle: number | false;
  seat: number | false;
  game: string;
  resource: string;
  playerId: number;
  serverId: number;
  [key: string]: unknown;
}

const cacheEvents: Record<keyof OxCache, Function[]> = {};

export const cache: OxCache = new Proxy(
  {
    resource: GetCurrentResourceName(),
    game: GetGameName(),
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  },
  {
    get(target: any, key: string) {
      const result = key ? target[key] : target;
      if (result !== undefined) return result;

<<<<<<< HEAD
      AddEventHandler(`ox_lib:cache:${key}`, (value: any) => {
=======
      cacheEvents[key] = [];

      AddEventHandler(`ox_lib:cache:${key}`, (value: any) => {
        const oldValue = target[key];
        const events = cacheEvents[key];

        events.forEach((cb) => cb(value, oldValue));

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        target[key] = value;
      });

      target[key] = exports.ox_lib.cache(key) || false;
      return target[key];
    },
  }
);

<<<<<<< HEAD
export const onCache = <T = any>(key: string, cb: (value: T) => void) => {
  AddEventHandler(`ox_lib:cache:${key}`, cb);
=======
export const onCache = <T extends keyof OxCache>(key: T, cb: (value: OxCache[T], oldValue: OxCache[T]) => void) => {
  if (!cacheEvents[key]) cache[key];

  cacheEvents[key].push(cb);
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
};
