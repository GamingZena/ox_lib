<<<<<<< HEAD
function streamingRequest(
  request: Function,
  hasLoaded: Function,
  assetType: string,
  asset: any,
  timeout?: number,
  ...args: any
): Promise<any> {
  return new Promise((resolve, reject) => {
    if (hasLoaded(asset)) resolve(asset);

    request(asset, ...args);

    if (typeof timeout !== 'number') timeout = 500;

    let i = 0;

    setTick(() => {
      if (hasLoaded(asset)) resolve(asset);

      i++;

      if (i === timeout) reject(`failed to load ${assetType} '${asset}' after ${timeout} ticks`);
    });
  });
}

export const requestAnimDict = (animDict: string, timeout?: number): Promise<string> => {
=======
import { waitFor } from '../../';

function streamingRequest<T extends string | number>(
  request: Function,
  hasLoaded: Function,
  assetType: string,
  asset: T,
  timeout: number = 30000,
  ...args: any
) {
  if (hasLoaded(asset)) return asset;

  request(asset, ...args);

  return waitFor(
    () => {
      if (hasLoaded(asset)) return asset;
    },
    `failed to load ${assetType} '${asset}' - this may be caused by\n- too many loaded assets\n- oversized, invalid, or corrupted assets`,
    timeout
  );
}

export const requestAnimDict = (animDict: string, timeout?: number) => {
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  if (!DoesAnimDictExist(animDict)) throw new Error(`attempted to load invalid animDict '${animDict}'`);

  return streamingRequest(RequestAnimDict, HasAnimDictLoaded, 'animDict', animDict, timeout);
};

<<<<<<< HEAD
export const requestAnimSet = (animSet: string, timeout?: number): Promise<string> =>
  streamingRequest(RequestAnimSet, HasAnimSetLoaded, 'animSet', animSet, timeout);

export const requestModel = (model: string | number, timeout?: number): Promise<number> => {
=======
export const requestAnimSet = (animSet: string, timeout?: number) =>
  streamingRequest(RequestAnimSet, HasAnimSetLoaded, 'animSet', animSet, timeout);

export const requestModel = (model: string | number, timeout?: number) => {
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  if (typeof model !== 'number') model = GetHashKey(model);
  if (!IsModelValid(model)) throw new Error(`attempted to load invalid model '${model}'`);

  return streamingRequest(RequestModel, HasModelLoaded, 'model', model, timeout);
};

<<<<<<< HEAD
export const requestNamedPtfxAsset = (ptFxName: string, timeout?: number): Promise<string> =>
  streamingRequest(RequestNamedPtfxAsset, HasNamedPtfxAssetLoaded, 'ptFxName', ptFxName, timeout);

export const requestScaleformMovie = (scaleformName: string, timeout?: number): Promise<string> =>
  streamingRequest(RequestScaleformMovie, HasScaleformMovieLoaded, 'scaleformMovie', scaleformName, timeout);

export const requestStreamedTextureDict = (textureDict: string, timeout?: number): Promise<string> =>
  streamingRequest(RequestStreamedTextureDict, HasStreamedTextureDictLoaded, 'textureDict', textureDict, timeout);

export const requestWeaponAsset = (weaponHash: string | number, timeout?: number, weaponResourceFlags: number = 31, extraWeaponComponentFlags: number = 0): Promise<string | number> =>
  streamingRequest(RequestWeaponAsset, HasWeaponAssetLoaded, 'weaponHash', weaponHash, timeout, weaponResourceFlags, extraWeaponComponentFlags);
=======
export const requestNamedPtfxAsset = (ptFxName: string, timeout?: number) =>
  streamingRequest(RequestNamedPtfxAsset, HasNamedPtfxAssetLoaded, 'ptFxName', ptFxName, timeout);

export const requestScaleformMovie = (scaleformName: string, timeout?: number) =>
  streamingRequest(RequestScaleformMovie, HasScaleformMovieLoaded, 'scaleformMovie', scaleformName, timeout);

export const requestStreamedTextureDict = (textureDict: string, timeout?: number) =>
  streamingRequest(RequestStreamedTextureDict, HasStreamedTextureDictLoaded, 'textureDict', textureDict, timeout);

export const requestWeaponAsset = (
  weaponHash: string | number,
  timeout?: number,
  weaponResourceFlags: number = 31,
  extraWeaponComponentFlags: number = 0
) =>
  streamingRequest(
    RequestWeaponAsset,
    HasWeaponAssetLoaded,
    'weaponHash',
    weaponHash,
    timeout,
    weaponResourceFlags,
    extraWeaponComponentFlags
  );
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
