import { cache } from '../cache/index';
import { printf } from 'fast-printf';

<<<<<<< HEAD
const dict: { [key: string]: string | number } = {};

export const locale = (str: keyof typeof dict, ...args: any[]) => {
=======
const dict: Record<string, string> = {};

function flattenDict(source: Record<string, any>, target: Record<string, string>, prefix?: string) {
  for (const key in source) {
    const fullKey = prefix ? `${prefix}.${key}` : key;
    const value = source[key];

    if (typeof value === 'object') flattenDict(value, target, fullKey);
    else target[fullKey] = String(value);
  }

  return target;
}

export const locale = (str: string, ...args: any[]) => {
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  const lstr = dict[str];

  if (!lstr) return str;

  if (lstr) {
    if (typeof lstr !== 'string') return lstr;

    if (args.length > 0) {
      return printf(lstr, ...args);
    }

    return lstr;
  }
<<<<<<< HEAD
=======

  return str;
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
};

export const getLocales = () => dict;

<<<<<<< HEAD
export const initLocale = () => {
  const lang = GetConvar('ox:locale', 'en');
  let locales: unknown = JSON.parse(LoadResourceFile(cache.resource, `locales/${lang}.json`));

  if (!locales) {
    console.warn(`could not load 'locales/${lang}.json'`);

    if (lang !== 'en') {
      locales = LoadResourceFile(cache.resource, 'locales/en.json');

      if (!locales) {
        console.warn(`could not load 'locales/en.json'`);
      }
    }

    if (!locales) return;
  }

  for (let [k, v] of Object.entries(locales)) {
=======
export function getLocale(resource: string, key: string) {
  let locale = dict[key];

  if (locale) console.warn(`overwritin existing locale '${key} (${locale})`);

  locale = exports[resource].getLocale(key);
  dict[key] = locale;

  if (!locale) console.warn(`no locale exists with key '${key} in resource '${resource}`);

  return locale;
}

function loadLocale(key: string): typeof dict {
  const data = LoadResourceFile(cache.resource, `locales/${key}.json`);

  if (!data) console.warn(`could not load 'locales/${key}.json'`);

  return JSON.parse(data) || {};
}

export const initLocale = (key?: string) => {
  const lang = key || exports.ox_lib.getLocaleKey();
  let locales = loadLocale('en');

  if (lang !== 'en') Object.assign(locales, loadLocale(lang));

  const flattened = flattenDict(locales, {});

  for (let [k, v] of Object.entries(flattened)) {
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    if (typeof v === 'string') {
      const regExp = new RegExp(/\$\{([^}]+)\}/g);

      const matches = v.match(regExp);

      if (matches) {
        for (const match of matches) {
          if (!match) break;
          const variable = match.substring(2, match.length - 1) as keyof typeof locales;
<<<<<<< HEAD
          let locale: string = locales[variable];
=======
          let locale: string = flattened[variable];
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

          if (locale) {
            v = v.replace(match, locale);
          }
        }
      }
    }

    dict[k] = v;
  }
};
<<<<<<< HEAD
=======

initLocale();
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
